Pod::Spec.new do |spec|
  # Name and version
  spec.name         = 'FingerprintPro'
  spec.version      = '2.1.5'

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

  spec.swift_versions = ['5.4', '5.5', '5.6', '5.7']

  spec.vendored_frameworks = 'FingerprintPro.xcframework'

  checksum = "4d43e8a8b3060e5d9f9970af18c367815a18329034740fe4d7d1c917109fb0eb"

  spec.source = { 
    :http => "https://fpjs-public.s3.amazonaws.com/ios/#{spec.version}/FingerprintPro-#{spec.version}-#{checksum}.xcframework.zip" 
  } 
end
