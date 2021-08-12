# [FingerprintJS Pro](https://fingerprintjs.com/) iOS Webview Integration

An example usage of FingerprintJS Pro inside a webview. The repo illustrates how to retrieve a FPJS visitor identifier in a mobile app.

There are two common use cases:

1. Using an external library to retrieve a FPJS visitor identifier in the native code;
2. Retriving a FPJS visitor identifier in the webview on the JavaScript level.

## Using as an external library

TBD

## Using inside a webview (JavaScript)

#### 1. Add a JavaScript interface to your webview

TBD

#### 2. Setup the JavaScript FPJS SDK in your webview

```js
function initFingerprintJS() {
  // Initialize an agent at application startup.
  const fpPromise = FingerprintJS.load({
    token: "your-browser-token",
    endpoint: "your-endpoint", // optional
    region: "your-region", // optional
  });

  // var androidDeviceId = window["fpjs-pro-android"].getDeviceId();

  // Get the visitor identifier when you need it.
  fpPromise
    .then((fp) =>
      fp.get({
        tag: {
          deviceId: // androidDeviceId,
          deviceType: "android",
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
