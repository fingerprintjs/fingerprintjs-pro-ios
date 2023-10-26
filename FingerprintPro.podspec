Pod::Spec.new do |spec|
  # Name and version
  spec.name         = 'FingerprintPro'
  spec.version      = '2.3.1'

  # License
  spec.license      = { type: 'Custom', file: 'LICENSE' }

  # Contact information
  spec.homepage     = 'https://fingerprint.com/'
  spec.authors      = {
    'FingerprintJS': 'ios@fingerprint.com',
    'Petr Palata': 'petr.palata@fingerprint.com'
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

  spec.swift_versions = ['5.7', '5.8', '5.9']

  spec.vendored_frameworks = 'FingerprintPro.xcframework'

  checksum = "8453335eb7f0da48db44f9a517b80e62b82d8e845044fbe4df9fdb47bd15c7c6"

  spec.source = { 
    :http => "https://fpjs-public.s3.amazonaws.com/ios/#{spec.version}/FingerprintPro-#{spec.version}-#{checksum}.xcframework.zip" 
  } 
end
