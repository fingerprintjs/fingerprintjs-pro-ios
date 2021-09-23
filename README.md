<p align="center">
  <a href="https://fingerprintjs.com">
    <img src="https://user-images.githubusercontent.com/10922372/129346814-a4e95dbf-cd27-49aa-ae7c-f23dae63b792.png" alt="FingerprintJS" width="312px" />
  </a>
</p>
<p align="center">
  <a href="https://discord.gg/39EpE2neBg">
    <img src="https://img.shields.io/discord/852099967190433792?style=logo&label=Discord&logo=Discord&logoColor=white" alt="Discord server">
  </a>
</p>

# [FingerprintJS Pro](https://fingerprintjs.com/) iOS Integrations

An example app and packages demonstrating [FingerprintJS Pro](https://fingerprintjs.com/) capabilities on the iOS platform. The repository illustrates how to retrieve a FingerprintJS Pro visitor identifier in a native mobile app. These integrations communicate with the FingerprintJS Pro API and require [browser token](https://dev.fingerprintjs.com/docs). If you are interested in the Android platform, you can also check our [FingerprintJS Pro Android integrations](https://github.com/fingerprintjs/fingerprintjs-pro-android-webview).

There are two typical use cases:
- Using our native library to retrieve a FingerprintJS Pro visitor identifier in the native code OR
- Retrieving visitor identifier using signals from the FingerprintJS Pro browser agent in the webview on the JavaScript level combined with vendor identifier.

## Using the external library to retrieve a FingerprintJS Pro visitor identifier
This integration approach uses our library FingerprintJSPro. It collects various signals from the iOS system, sends them to the FingerprintJS Pro API for processing, and retrieves an accurate visitor identifier.

### 1. Installation

#### CocoaPods

Specify the following dependency in your `Podfile`:

```ruby
pod 'FingerprintJSPro', '~> 1.1.0'
```

#### Swift Package Manager

Add the following dependency to your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/fingerprintjs/fingerprintjs-pro-ios-integrations", .upToNextMajor(from: "1.1.0"))
]
```

### 2. Import

```swift
import FingerprintJSPro
```

### 3. Get the visitor identifier
You can find your [browser api token](https://dev.fingerprintjs.com/docs) in your [dashboard](https://dashboard.fingerprintjs.com/subscriptions/).

```swift
FingerprintJSProFactory
    .getInstance(
        token: "your-browser-token",
        endpoint: nil, // optional
        region: nil // optional
    )
    .getVisitorId { result in
        switch result {
        case let .failure(error):
            print("Error: ", error.localizedDescription)
        case let .success(visitorId):
            print("Success: ", visitorId)
        }
    }
```
#### Params
- `token: string` - API token from the [FingerprintJS dashboard](https://dashboard.fingerprintjs.com/)
- `endpoint: URL?` - `nil` for default endpoint, possible format for custom endpoint: `URL(string: "https://fp.yourdomain.com")`
- `region: String?` - `nil` for the Global region, `eu` for the European region

#### [Tags](https://dev.fingerprintjs.com/v2/docs/js-agent#tag) support

```swift
FingerprintJSProFactory
    .getInstance(
        token: "your-browser-token",
        endpoint: nil, // optional
        region: nil // optional
    )
    .getVisitorId(tags: ["sessionId": sessionId]) { result in
        switch result {
        case let .failure(error):
            print("Error: ", error.localizedDescription)
        case let .success(visitorId):
            print("Success: ", visitorId)
        }
    }
```


## Using inside a webview with JavaScript
This approach uses signals from [FingerprintJS Pro browser agent](https://dev.fingerprintjs.com/docs/quick-start-guide#js-agent) together with iOS device [vendor identifier](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor). The vendor identifier is added to the [`tag` field](https://dev.fingerprintjs.com/docs#tagging-your-requests) in the given format. FingerprintJS Pro browser agent adds an additional set of signals and sents them to the FingerprintJS Pro API. Eventually, the API returns accurate visitor identifier.

### 1. Add a JavaScript interface to your webview

```swift
let vendorId = UIDevice.current.identifierForVendor.flatMap { "'\($0.uuidString)'" } ?? "undefined"

let script = WKUserScript(source: "window.fingerprintjs = { 'vendorId' : \(vendorId) }",
                          injectionTime: .atDocumentStart,
                          forMainFrameOnly: false)

webView.configuration.userContentController.addUserScript(script) // the webview should contain a webpage with injected and configured fingerprintjs-pro

```

### 2. Setup the JavaScript FingerprintJS Pro integration in your webview

```js
function initFingerprintJS() {
  // Initialize an agent at application startup.
  const fpPromise = FingerprintJS.load({
    token: "your-browser-token",
    endpoint: "your-endpoint", // optional
    region: "your-region", // optional
  });

  // Get the visitor identifier when you need it.
  fpPromise
    .then((fp) =>
      fp.get({
        environment: {
          deviceId: window.fingerprintjs.vendorId, // use vendor ID as device ID
          type: "ios",
        }
      })
    )
    .then((result) => console.log(result.visitorId));
}
```
#### Params
You can find your [browser token](https://dev.fingerprintjs.com/docs) in your [dashboard](https://dashboard.fingerprintjs.com/subscriptions/).
Params format and properties are the same as in [JS agent](https://dev.fingerprintjs.com/docs/js-agent)

The full example content view for SwiftUI with configured fingerprintjs-pro might look like:
```swift
import SwiftUI
import WebKit
 
struct ContentView: View {
    var body: some View {
        Webview(url: URL(string: "https://eager-hermann-4ea017.netlify.app")!) // this URL should refer to the webpage with injected and configured fingerprintjs-pro
    }
}
 
struct Webview: UIViewRepresentable {
    let url: URL
 
    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()
 
        let vendorId = UIDevice.current.identifierForVendor.flatMap { "'\($0.uuidString)'" } ?? "undefined"
        
        let script = WKUserScript(source: "window.fingerprintjs = { 'vendorId' : \(vendorId) }", injectionTime: .atDocumentStart, forMainFrameOnly: false)
 
        webview.configuration.userContentController.addUserScript(script) 
 
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
 
        return webview
    }
 
    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}
```

## Additional Resources
[FingerprintJS Pro documentation](https://dev.fingerprintjs.com/docs)

## License
This library is MIT licensed.
