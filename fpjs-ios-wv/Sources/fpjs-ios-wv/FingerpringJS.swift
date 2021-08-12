#if !os(macOS)
    import UIKit
    import WebKit

    public protocol FingerprintJS {
        typealias ResultHandler = (Result<VisitorId, Swift.Error>) -> Void

        func track(handler: @escaping ResultHandler)
    }

    public extension FingerprintJS {
        typealias Factory = FingerprintJSFactory
        typealias VisitorId = String
    }

    public enum FingerprintJSFactory {
        public static func getInstance(token: String, endpoint: URL? = nil, deviceId: String? = nil) -> FingerprintJS {
            return Impl(token: token, endpoint: endpoint, deviceId: deviceId)
        }
    }

    public enum Error: Swift.Error {
        case `internal`
    }

    private struct Settings {
        internal struct InitializationArguments: Codable {
            let token: String
            let endpoint: URL?
            let region: String?
        }

        internal struct RequestParameters: Codable {
            internal struct Tags: Codable {
                let deviceId: String?
                let deviceType: String?
            }

            // MARK: - Internal

            internal let tags: Tags?
        }

        // MARK: - Internal

        internal var initializationArguments: InitializationArguments
        internal var requestParameters: RequestParameters
    }

    // MARK: - Private

    private final class Impl: NSObject, FingerprintJS, WKNavigationDelegate, WKScriptMessageHandler {
        // MARK: - Lifecycle

        public init(token: String, endpoint: URL? = nil, deviceId: String? = nil) {
            settings = Settings(initializationArguments: .init(token: token,
                                                               endpoint: endpoint,
                                                               region: nil),
                                requestParameters: .init(tags: .init(deviceId: deviceId,
                                                                     deviceType: "ios")))

            super.init()
        }

        // MARK: - Public

        public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            do {
                guard message.name == messageHandlerName
                else {
                    throw Error.internal
                }

                guard let visitorId = message.body as? String
                else {
                    throw Error.internal
                }

                handler?(.success(visitorId))
            } catch {
                handler?(.failure(error))
            }
        }

        public func track(handler: @escaping ResultHandler) {
            do {
                guard let scriptString = Bundle.module.url(forResource: "fp.min", withExtension: "js")
                    .map({ $0.path })
                    .flatMap(FileManager.default.contents)?
                    .flatMap({ String(data: $0, encoding: .utf8) })
                else {
                    throw Error.internal
                }

                let parametersString = try settings.requestParameters.makeJSONString()
                let argumentsString = try settings.initializationArguments.makeJSONString()

                let html: String =
                    """
                    <html><body><script>
                     var FingerprintJS = \(scriptString);
                     FingerprintJS.load(\(argumentsString))
                            .then(fp => fp.get(\(parametersString)))
                            .then(result => window.webkit.messageHandlers.\(messageHandlerName).postMessage(result.visitorId));
                    </script></body></html>
                    """

                self.handler = {
                    self.webView = nil
                    self.handler = nil

                    handler($0)
                }

                guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
                    throw Error.internal
                }

                DispatchQueue.main.async {
                    self.webView = self.makeWebView(in: vc)
                    self.webView?.loadHTMLString(html, baseURL: self.settings.initializationArguments.endpoint)
                }

            } catch {
                handler(.failure(error))
            }
        }

        // MARK: - Internal

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Swift.Error) {
            handler?(.failure(error))
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Swift.Error) {
            handler?(.failure(error))
        }

        // MARK: - Private

        private let settings: Settings

        private var handler: ResultHandler?

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

            let webView = WKWebView(frame: .init(x: 1, y: 1, width: 0, height: 0), configuration: config)
            webView.translatesAutoresizingMaskIntoConstraints = false

            viewController.view.addSubview(webView)

            return webView
        }
    }

    private extension Encodable {
        func makeJSONString() throws -> String {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            let data = try encoder.encode(self)

            if let result = String(data: data, encoding: .utf8) {
                return result
            } else {
                throw Error.internal
            }
        }
    }

#endif
