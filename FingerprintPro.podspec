Pod::Spec.new do |spec|
  # Name and version
  spec.name         = 'FingerprintPro'
  spec.version      = '2.1.6'

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

  spec.ios.deployment_target = '12.0'
  spec.tvos.deployment_target = '12.0'

  spec.swift_versions = ['5.5', '5.6', '5.7']

  spec.vendored_frameworks = 'FingerprintPro.xcframework'

  checksum = "fb845e35d253271df17435d8bdf6b1ba2088617f2ba23c0e2bb4433b014bf498"

  spec.source = { 
    :http => "https://fpjs-public.s3.amazonaws.com/ios/#{spec.version}/FingerprintPro-#{spec.version}-#{checksum}.xcframework.zip" 
  } 
end
