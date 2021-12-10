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

# [FingerprintJS Pro](https://fingerprintjs.com/) iOS

An example app and packages demonstrating [FingerprintJS Pro](https://fingerprintjs.com/) capabilities on the iOS platform. The repository illustrates how to retrieve a FingerprintJS Pro visitor identifier in a native mobile app. The library communicates with the FingerprintJS Pro API and requires [browser token](https://dev.fingerprintjs.com/docs). If you are interested in the Android platform, you can also check our [FingerprintJS Pro Android](https://github.com/fingerprintjs/fingerprintjs-pro-android-webview).

There are two typical use cases:
- Using our native library to retrieve a FingerprintJS Pro visitor identifier in the native code OR
- Retrieving visitor identifier using signals from the FingerprintJS Pro browser agent in the webview on the JavaScript level combined with vendor identifier.

## Quick start
Integrate the FingerprintJS Pro iOS framework to your project. The framework collects various signals from the iOS system, sends them to the FingerprintJS Pro API for processing, and retrieves a very accurate and stable identifier.

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

For using FingerprintJS Pro iOS inside of an PWA check the [full API reference](docs/client_api.md).


## Additional Resources
[FingerprintJS Pro documentation](https://dev.fingerprintjs.com/docs)

## License
This library is MIT licensed.
