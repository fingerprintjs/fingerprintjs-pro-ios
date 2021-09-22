/**
 Copyright (c) FingerprintJS, Inc, 2021 (https://fingerprintjs.com)
 */

#if !os(macOS)
    import UIKit
    import WebKit

    public protocol FingerprintJSProClient {
        typealias Tags = [String: Any]

        typealias VisitorId = String
        typealias VisitorIdHandler = (Result<VisitorId, Swift.Error>) -> Void

        func getVisitorId(_ handler: @escaping VisitorIdHandler)
        func getVisitorId(tags: Tags?, _ handler: @escaping VisitorIdHandler)
    }

    public enum FingerprintJSProFactory {
        public static func getInstance(
            token: String,
            endpoint: URL? = nil,
            region: String? = nil
        ) -> FingerprintJSProClient {
            FingerprintJSProClientImpl(token: token, endpoint: endpoint, region: region)
        }
    }

    internal enum Error: LocalizedError, CustomStringConvertible {
        case `internal`
        case message(String)

        // MARK: - Public

        public var errorDescription: String? {
            description
        }

        // MARK: - Internal

        var description: String {
            switch self {
            case .internal:
                return "Unknown error"
            case let .message(text):
                return text
            }
        }
    }

    internal struct Environment: Codable {
        static var `default`: Self {
            Self(deviceId: getIdentifierForVendor(),
                 type: "ios")
        }

        let deviceId: String?
        let type: String?
    }

    private struct Settings: Codable {
        let token: String
        let endpoint: URL?
        let region: String?
    }

    // MARK: - Private

    private final class FingerprintJSProClientImpl: NSObject,
        FingerprintJSProClient,
        WKNavigationDelegate,
        WKScriptMessageHandler
    {
        // MARK: - Lifecycle

        public init(token: String, endpoint: URL? = nil, region: String? = nil) {
            settings = Settings(token: token,
                                endpoint: endpoint,
                                region: region)

            super.init()
        }

        // MARK: - Public

        public func userContentController(_ userContentController: WKUserContentController,
                                          didReceive message: WKScriptMessage)
        {
            do {
                guard message.name == messageHandlerName
                else {
                    throw Error.internal
                }

                guard let body = message.body as? [String: Any] else {
                    throw Error.internal
                }

                if let visitorId = body["success"] as? String {
                    handler?(.success(visitorId))
                } else if let error = body["error"] as? String {
                    throw Error.message(error)
                } else {
                    throw Error.internal
                }

            } catch {
                handler?(.failure(error))
            }
        }

        public func getVisitorId(_ handler: @escaping VisitorIdHandler) {
            getVisitorId(tags: nil, handler)
        }

        public func getVisitorId(tags: Tags?, _ handler: @escaping VisitorIdHandler) {
            do {
                guard let scriptString = Bundle.module.url(forResource: "fp.min", withExtension: "js")
                    .map(\.path)
                    .flatMap(FileManager.default.contents)?
                    .flatMap({ String(data: $0, encoding: .utf8) })
                else {
                    throw Error.internal
                }

                var parameters: [String: Any] = [:]

                parameters["environment"] = try encode(Environment.default)

                if let tags = tags,
                   tags.isEmpty == false
                {
                    parameters["tags"] = tags
                }

                let parametersString = try encode(parameters)
                let settingsString = try encode(settings) as String
                let messageHandler = "window.webkit.messageHandlers.\(messageHandlerName)"

                let html: String =
                    """
                    <html><body><script>
                     \(scriptString);
                     FingerprintJS.load(\(settingsString))
                            .then(fp => fp.get(\(parametersString)))
                            .then(result => \(messageHandler).postMessage({ success: result.visitorId }))
                            .catch(e => \(messageHandler).postMessage({ error: e.message }));
                    </script></body></html>
                    """

                self.handler = {
                    self.webView = nil
                    self.handler = nil

                    handler($0)
                }

                guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
                    throw Error.message("UIApplication.shared.keyWindow.rootViewController must be loaded before use `getVisitorId` method")
                }

                let block = {
                    self.webView = self.makeWebView(in: vc)
                    self.webView?.loadHTMLString(html, baseURL: self.settings.endpoint)
                }

                if Thread.isMainThread {
                    block()
                } else {
                    DispatchQueue.main.async { block() }
                }

            } catch {
                handler(.failure(error))
            }
        }

        // MARK: - Internal

        func webView(_ webView: WKWebView,
                     didFailProvisionalNavigation navigation: WKNavigation!,
                     withError error: Swift.Error)
        {
            handler?(.failure(error))
        }

        func webView(_ webView: WKWebView,
                     didFail navigation: WKNavigation!,
                     withError error: Swift.Error)
        {
            handler?(.failure(error))
        }

        // MARK: - Private

        private let settings: Settings

        private var handler: VisitorIdHandler?

        private lazy var messageHandlerName: String = {
            UUID().uuidString
                .components(separatedBy: .letters.inverted)
                .joined()
        }()

        private var webView: WKWebView? {
            didSet {
                oldValue?.removeFromSuperview()
                oldValue?.configuration.userContentController.removeScriptMessageHandler(forName: messageHandlerName)
            }
        }

        private func makeWebView(in viewController: UIViewController) -> WKWebView {
            let config = WKWebViewConfiguration()
            config.userContentController.add(self, name: messageHandlerName)

            let webView = WKWebView(frame: .init(x: 1.0, y: 1.0, width: 0, height: 0),
                                    configuration: config)
            webView.translatesAutoresizingMaskIntoConstraints = false

            viewController.view.addSubview(webView)

            return webView
        }

        private func encode<T: Encodable>(_ parameters: T) throws -> Any {
            guard let data = try encode(parameters).data(using: .utf8) else {
                throw Error.internal
            }

            let any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

            return any
        }

        private func encode<T: Encodable>(_ parameters: T) throws -> String {
            let encoder = JSONEncoder()

            let data = try encoder.encode(parameters)

            if let result = String(data: data, encoding: .utf8) {
                return result
            } else {
                throw Error.internal
            }
        }

        private func encode(_ parameters: [String: Any]) throws -> String {
            let encoder = JSONSerialization.self

            let data = try encoder.data(withJSONObject: parameters, options: [])

            if let result = String(data: data, encoding: .utf8) {
                return result
            } else {
                throw Error.internal
            }
        }
    }

    #if !SWIFT_PACKAGE
        extension Bundle {
            static var module: Bundle {
                Bundle(for: FingerprintJSProClientImpl.self)
            }
        }
    #endif

    private func getIdentifierForVendor() -> String? {
        let account = defaultAccount(for: "identifierForVendor")

        if let data = try? Keychain.readKey(account: account),
           let id = String(data: data, encoding: .utf8)
        {
            return id
        } else if let id = UIDevice.current.identifierForVendor?.uuidString,
                  let data = id.data(using: .utf8)
        {
            try? Keychain.storeKey(data, account: account)
            return id
        }
        return nil
    }

#endif
