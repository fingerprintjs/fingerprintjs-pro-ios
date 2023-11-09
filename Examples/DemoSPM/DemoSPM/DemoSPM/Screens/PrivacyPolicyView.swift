//
//  PrivacyPolicyView.swift
//  DemoSPM
//
//  Created by Petr Palata on 07.09.2022.
//

import SwiftUI
import WebKit

struct PrivacyPolicyView: View {

    private static let privacyPolicyURL = Bundle.main.url(
        forResource: "POLICY",
        withExtension: "html"
    )

    @State private var loaded: Bool = false

    var body: some View {
        ZStack {
            WebView(url: PrivacyPolicyView.privacyPolicyURL, loaded: $loaded)
            VStack(spacing: 10) {
                ProgressView()
                Text("Loading...")
            }
            .padding(20)
            .background(.background)
            .cornerRadius(10)
            .shadow(radius: 5)
            .opacity(loaded ? 0 : 1)
        }
    }
}

private extension PrivacyPolicyView {

    struct WebView: UIViewRepresentable {

        var url: URL?
        @Binding var loaded: Bool

        private let wrapper = WebViewWrapper()

        func makeUIView(context: Context) -> WKWebView {
            wrapper.delegate = self
            return wrapper.wkWebView
        }

        func updateUIView(_ webView: WKWebView, context: Context) {
            if let url = url {
                let request = URLRequest(url: url)
                webView.load(request)
            } else {
                loaded = true
            }
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            loaded = true
        }
    }

    final class WebViewWrapper: NSObject, WKNavigationDelegate {

        var delegate: WebView? = nil
        let wkWebView = WKWebView()

        override init() {
            super.init()
            wkWebView.navigationDelegate = self
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            delegate?.webView(webView, didFinish: navigation)
        }

        @MainActor
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            if let url = navigationAction.request.url {
                await UIApplication.shared.open(url)
            }
            return navigationAction.request.url == privacyPolicyURL ? .allow : .cancel
        }
    }
}
