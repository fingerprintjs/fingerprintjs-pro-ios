# [FingerprintJS Pro](https://fingerprintjs.com/) iOS Webview Integration

An example usage of FingerprintJS Pro inside a webview. The repo illustrates how to retrieve a FPJS visitor identifier in a mobile app.

There are two common use cases:

1. Using an external library to retrieve a FPJS visitor identifier in the native code;
2. Retriving a FPJS visitor identifier in the webview on the JavaScript level.

## Using as an external library

### 1. Installation

#### CocoaPods

Specify the following dependency in your `Podfile`:

```ruby
pod 'FingerprintJSPro', '~> 0.1.0'
```

#### Swift Package Manager

Add the following dependency to your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/fingerprintjs/fingerprintjs-pro-ios-webview", .upToNextMajor(from: "0.1.0"))
]
```

### 2. Import

```swift
import FingerprintJSPro
```

### 3. Usage

```swift
FingerprintJSPro.Factory
    .getInstance(
        token: `your-browser-token`,
        endpoint: nil, // optional
        region: nil // optional
    )
    .getVisitorId { visitorId in
        print(visitorId)
    }
```

## Using inside a webview (JavaScript)

#### 1. Add a JavaScript interface to your webview

```swift
let vendorId = UIDevice.current.identifierForVendor?.uuidString ?? "undefined"

let script = WKUserScript(source: "window.fingerprintjs.vendorId = \(vendorId)",
                          injectionTime: .atDocumentStart,
                          forMainFrameOnly: false)

webView.configuration.userContentController.addUserScript(script)

```

#### 2. Setup the JavaScript FPJS SDK in your webview

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
        tag: {
          deviceId: window.fingerprintjs.vendorId, // use vendor ID as device ID
          deviceType: "ios",
        },
      })
    )
    .then((result) => console.log(result.visitorId));
}
```

[Read more.](https://dev.fingerprintjs.com/docs)

## License

This library is MIT licensed.
Copyright FingerprintJS, Inc. 2020-2021.
