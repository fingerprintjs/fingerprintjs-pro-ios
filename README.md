<p align="center">
  <a href="https://fingerprintjs.com">
    <img src="logo.svg" alt="FingerprintJS" width="312px" />
  </a>
</p>
<p align="center">
  <a href="https://discord.gg/39EpE2neBg">
    <img src="https://img.shields.io/discord/852099967190433792?style=logo&label=Discord&logo=Discord&logoColor=white" alt="Discord server">
  </a>
</p>

# FingerprintJS Pro iOS 
### Official iOS agent & SDK for 100% accurate device identification, created for the FingerprintJS Pro Server API.

```swift

// Trust your user's identifiers with the FingerprintJS Pro

FingerprintJSProFactory
    .getInstance(
        token: "my-api-token",
        endpoint: nil, // optional
        region: nil // optional
    )
    .getVisitorId { result in
        switch result {
        case let .failure(error):
            print("Error: ", error.localizedDescription)
        case let .success(visitorId):
            // Prevent fraud cases in your apps with a unique
            // sticky and reliable ID provided by FingerprintJS Pro.
            print("Success: ", visitorId)
        }
    }
```

## #1 library for iOS device identification

FingerprintJS Pro is a professional visitor identification service that processes all information server-side and transmits it securely to your servers using server-to-server APIs.

Retrieve an accurate, sticky an stable [FingerprintJS Pro](https://fingerprintjs.com/) visitor identifier in an iOS app. This library communicates with the FingerprintJS Pro API and requires a [token](https://dev.fingerprintjs.com/docs). 

If you are interested in the Android platform, you can also check our [FingerprintJS Pro Android](https://github.com/fingerprintjs/fingerprintjs-pro-android).

## Features

- Retrive a visitor ID in mobile apps or in  a [webview on the JavaScript level](docs/client_api.md#using-inside-a-webview-with-javascript)
- [Server-to-Server API](https://dev.fingerprintjs.com/docs/server-api)

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


## Additional Resources
- [FingerprintJS Pro documentation](https://dev.fingerprintjs.com/docs)
- [Full API reference](docs/client_api.md).

## License
This library is MIT licensed.
