Pod::Spec.new do |spec|
  # Name and version
  spec.name         = 'FingerprintPro'
  spec.version      = '2.7.0'

  # License
  spec.license      = { type: 'Custom', file: 'LICENSE' }

  # Contact information
  spec.homepage     = 'https://fingerprint.com/'
  spec.authors      = {
    'Fingerprint.com': 'support@fingerprint.com'
  }

  # Fingerprint Pro library description
  spec.summary = 'Pro version of Fingerprint\'s lightweight device fingerprinting library for iOS'
  spec.description = <<-DESC
  Fingerprint PRO is a simple wrapper around Fingerprint\'s API that collects device information
  to uniquely identify iOS devices. The library communicates with the Fingerprint backend to send
  device signals (hardware information, available identifiers, OS information and device settings)
  and get a more precise fingerprint in return.
  DESC

  spec.ios.deployment_target = '13.0'
  spec.tvos.deployment_target = '15.0'

  spec.swift_versions = ['5.9', '5.10', '6.0']

  spec.vendored_frameworks = 'FingerprintPro.xcframework'

  checksum = "cdceb6f13d2302bfdbf95f26d013264c678058ffbf1226034aaa0be1763d796b"

  spec.source = {
    :http => "https://fpjs-public.s3.amazonaws.com/ios/#{spec.version}/FingerprintPro-#{spec.version}-#{checksum}.xcframework.zip" 
  }
end
