//
//  DemoView.swift
//  DemoJavaScript
//
//  Created by Pavel Gerashchenko on 17.08.2021.
//

import SwiftUI
import WebKit

// MARK: - DemoView

struct DemoView: View {
    var body: some View {
        // This URL should refer to the webpage with injected and configured fingerprintjs-pro
        Webview(url: URL(string: "https://eager-hermann-4ea017.netlify.app")!)
    }
}

// MARK: - Webview

private struct Webview: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()

        let vendorId = UIDevice.current.identifierForVendor.flatMap { "'\($0.uuidString)'" } ?? "undefined"

        let script = WKUserScript(source: "window.fingerprintjs = { 'vendorId' : \(vendorId) }",
                                  injectionTime: .atDocumentStart,
                                  forMainFrameOnly: false)

        webview.configuration.userContentController.addUserScript(script)

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}
