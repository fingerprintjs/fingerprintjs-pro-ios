<p align="center">
  <a href="https://fingerprint.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="resources/logo_light.svg" />
      <source media="(prefers-color-scheme: light)" srcset="resources/logo_dark.svg" />
      <img src="resources/logo_light.svg" alt="Fingerprint" width="312px" />
    </picture>
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.10%20%7C%205.9-red" alt="Supported Swift versions">
  <img src="https://img.shields.io/badge/Platforms-iOS%2013.0+%20%7C%20tvOS%2015.0+-lightgrey" alt="Supported platforms">
  <a href="https://github.com/fingerprintjs/fingerprint-device-intelligence-ios-demo">
    <img src="https://img.shields.io/badge/Fingerprint%20Pro%20Demo%20App-red" alt="Fingerprint Pro Demo App">
  </a>
</p>

<p align="center">
  <a href="https://discord.gg/39EpE2neBg">
    <img src="https://img.shields.io/discord/852099967190433792?style=for-the-badge&label=Discord&logo=Discord&logoColor=white" alt="Discord server">
  </a>
</p>

# Fingerprint Identification SDK for iOS

[Fingerprint’s Device Intelligence platform for iOS](https://dev.fingerprint.com/docs/ios) helps you to accurately identify the devices on which your mobile app is being used. The platform also provides high-quality [Smart Signals](https://dev.fingerprint.com/docs/smart-signals-overview#smart-signals-for-mobile-devices) that will help you identify risky transactions before they happen.

> [!TIP]
> Check out the [Fingerprint Pro Demo App](https://github.com/fingerprintjs/fingerprint-device-intelligence-ios-demo) to better understand and experience the capabilities of our device intelligence platform.

## Quick Start

### Requirements

* iOS 13.0 or higher (or tvOS 15.0 or higher)
* Xcode 15.0 or higher

### Installation Steps

1. Add `FingerprintPro` as a dependency

   a) Use Swift Package Manager
   ```swift
   // Package.swift
   let package = Package(
       ...
   
       dependencies: [
           .package(url: "https://github.com/fingerprintjs/fingerprintjs-pro-ios", from: "2.2.0")
       ]
   
       ...
   )
   ```
   b) Use Cocoapods
   ```ruby
   # Podfile
   pod 'FingerprintPro', '~> 2.2'
   ```

2. Obtain a public API key from [Fingerprint Dashboard](https://dashboard.fingerprint.com)

3. Use the library to interface with our platform and get a `visitorId`

```swift
import FingerprintPro

// Creates Fingerprint Pro client for the global region
let client = FingerprintProFactory.getInstance("<your-api-key>")

do {
    let visitorId = try await client.getVisitorId()
    print(visitorId)
} catch {
    // handle error
}
```

## Region and Domain Configuration

It is possible to manually select an endpoint from a predefined set of regions. The library uses the `global` region by default. The list of existing regions can be found in our [developer documentation](https://dev.fingerprint.com/docs/regions).

Besides selecting a region from the predefined set, it's possible to point the library to a custom endpoint that has the correct API interface with the `.custom(domain:)` enum value. The `domain` parameter represents the full URL of the endpoint. If the endpoint isn't a valid URL, the library throws a specific error during API calls.

Note: API keys are region-specific so make sure you have selected the correct region during initialization. 

### Selecting a Region

```swift
let region: Region = .ap
let configuration = Configuration(apiKey: <your-api-key>, region: region)

// Creates a client for the Asia/Pacific region
let client = FingerprintProFactory.getInstance(configuration)

// Uses the Asia/Pacific endpoint for API calls
let visitorId = try? await client.getVisitorId() 
```

### Using Custom Endpoint Domain

```swift
let customDomain: Region = .custom(domain: "https://example.com")
let configuration = Configuration(apiKey: <your-api-key>, region: customDomain)

// Creates client for the Asia/Pacific region
let client = FingerprintProFactory.getInstance(configuration)

// Uses https://example.com to make an API call
let visitorId = try? await client.getVisitorId() 
```

## Default and Extended Response Formats

The backend can return either a default or an extended response. Extended response contains more metadata that further explain the fingerprinting process. Both default and extended responses are captured in the `FingerprintResponse` object. 

Using `getVisitorIdResponse(_)` with no parameters returns the default response unless `extendedResponseFormat` was set to true during library initialization.

```swift
let client = FingerprintProFactory.getInstance("<your-api-key>")

// returns default respones format
let extendedResult = try? await client.getVisitorIdResponse()
```

### Default Response

<details>
<summary>Show Default Response</summary>

```swift
public struct FingerprintResponse {
    public let version: String
    public let requestId: String
    public let visitorId: String
    public let confidence: Float
}
```
</details>

### Extended Result

Extended result contains extra information, namely the IP address and its geolocation. The extended result comes from the backend if the `extendedResponseFormat` flag is set on the `Configuration` object passed into the `getInstance()` factory method during client initialization.

```swift
let configuration = Configuration(apiKey: <your-api-key>, extendedResponseFormat: true)

let client = FingerprintProFactory.getInstance(configuration)

// returns extended response format
let extendedResult = try? await client.getVisitorIdResponse()
```

The extended format has the following fields.

<details>
<summary>Show Extended Response</summary>

```swift
public struct FingerprintResponse {
    public let version: String
    public let requestId: String
    public let visitorId: String
    public var visitorFound: Bool { get }
    public let confidence: Float

    public let ipAddress: String?
    public let ipLocation: IPLocation?
    public let firstSeenAt: SeenAt?
    public let lastSeenAt: SeenAt?
}
```
</details>

<details>
<summary>Show IP Location Structure</summary>

```swift
public struct IPLocation: Decodable {
    public let city: IPGeoInfo?
    public let country: IPGeoInfo?
    public let continent: IPGeoInfo?
    public let longitude: Float?
    public let latitude: Float?
    public let postalCode: String?
    public let timezone: String?
    public let accuracyRadius: UInt?
    public let subdivisions: [IPLocationSubdivision]?
}

public struct IPLocationSubdivision: Decodable {
    let isoCode: String
    let name: String
}

public struct IPGeoInfo: Decodable {
    let name: String
    let code: String?
}
```
</details>

## Metadata

The `Metadata` structure can be passed to any library request through a parameter. Metadata serve as an extension point for developers, allowing sending additional data to our backend. The metadata can be then used to filter and identify the requests.

`Metadata` consist of `linkedId` and `tags`. `LinkedId` is a string value that can uniquely identify the request among the rest. `Tags` is an arbitrary set of data (with the only limitation that the data has to be encodable into a JSON object) that are sent to the backend and passed into the webhook call.

The following example sets `linkedId`, `tags` and sends it to the backend within a request.

```swift
let client = FingerprintProFactory.getInstance("<your-api-key>")

var metadata = Metadata(linkedId: "unique-id")
metadata.setTag("purchase", forKey: "actionType")
metadata.setTag(10, forKey: "purchaseCount")

let visitorId = try? await client.getVisitorId(metadata) 
```

## Errors

The library parses backend errors and introduces its own error enum called `FPJSError`.
