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

## Quick Start

We haven't released our library publicly yet (through SPM and CocoaPods). If you'd like to try it out in a PoC application, shoot us an email with the details to ios@fingerprint.com and we'll send over the binary.

### Installation Steps

1. Add `FingerprintJSPro` as a dependency (drag and drop the .xcframework file into your Xcode project)

2. Obtain a public API key from [FingerprintJS Dashboard](https://dashboard.fingerprint.com)

3. Use the library to interface with our service and get a `visitorId`

```swift
// Creates FingerprintJS Pro client for the global region
let client = FingerprintJSProFactory.getInstance("<your-api-key>")

do {
    let response = try await client.getVisitorId()
    print(response.visitorId)
} catch {
    // process error
}
```

## Region and Domain Configuration

It is possible to manually select an endpoint from a predefined set of regions. The library uses the `global` region by default. The list of existing regions can be found in our [developer documentation](https://dev.fingerprint.com/docs/regions).

Besides selecting a region from the predefined set, it's possible to point the library to a custom endpoint that has the correct API interface with the `.custom(String)` enum value. The `String` parameter represents the full URL of the endpoint. If the endpoint isn't a valid URL, the library throws a specific error during the `getVisitorId()` calls.


Note: API keys are region-specific so make sure you have the correct one. 

### Selecting a Region

```swift
let region: Region = .ap

// Creates a client for the Asia/Pacific region
let client = FingerprintJSProFactory.getInstance("<your-api-key>", region: region)

// Uses the Asia/Pacific endpoint for API calls
let response = try? await client.getVisitorId() 
```

### Using Custom Endpoint Domain

```swift
let customDomain: Region = .custom("https://example.com")
let configuration = Configuration(apiKey: <your-api-key>, region: customDomain)

// Creates client for the Asia/Pacific region
let client = FingerprintJSProFactory.getInstance(configuration)

// Uses https://example.com to make an API call
let response = try? await client.getVisitorId() 
```

# Default and Extended Response Formats

The backend can return either a default or an extended response. Extended response contains more metadata that further explain the fingerprinting process. Both eefault and extended responses are captured in the `FingerprintResponse` object. 

Using `getVisitorId(_)` with no parameters returns the default response and further contains the `extendedResult` boolean flag which determines whether the response should be default or extended.

```swift
let client = FingerprintJSProFactory.getInstance("<your-api-key>")
let extendedResult = try? await client.getVisitorIdResponse()
```

## Default Response

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

## Extended Result
Extended result contains extra information, namely the IP address and its geolocation. The extended result comes from the backend if the `extendedResponseFormat` flag is set on the `Configuration` object passed into the `getInstace(_)` factory method during client initialization.

The extended format has the following fields.

<details>
<summary>Show Extended Response</summary>

```swift
public struct FingerprintResponse {
    public let version: String
    public let requestId: String
    public let visitorId: String
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

The `Metadata` structure can be passed to any library request through a parameter. Metadata serve as an extension point for developers that allows them to send additional data to our backend. The metadata can be then used to filter and identify the requests.

`Metadata` consist of `linkedId` and `tags`. `LinkedId` is a string value that can uniquely identify the request among the rest. `Tags` is an arbitrary set of data (with the only limitation that the data has to be encodable into a JSON object) that are sent to the backend and passed into the webhook call.

The following example sets `linkedId`, `tags` and sends it to the backend within a request.


```swift
let client = FingerprintJSProFactory.getInstance("<your-api-key>")

var metadata = Metadata(linkedId: "unique-id")
metadata.setTag("purchase", for: "actionType")
metadata.setTag(10, for: "purchaseCount")

let response = try? await client.getVisitorId(metadata) 
```

## Errors
The library parses backend errors and introduces its own error enum called `FPJSError`.
