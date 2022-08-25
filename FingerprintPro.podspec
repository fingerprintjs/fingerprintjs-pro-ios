Pod::Spec.new do |spec|
  # Name and version
  spec.name         = 'FingerprintPro'
  spec.version      = '2.0.2'

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
  spec.tvos.deployment_target = '13.0'

  spec.swift_versions = ['5.3', '5.4', '5.5', '5.6']

  spec.vendored_frameworks = 'FingerprintPro.xcframework'

  spec.source = { 
    :http => "https://fpjs-public.s3.amazonaws.com/ios/2.0.2/FingerprintPro-2.0.2-c2361af3e66764ab400d27cff300ed2134bd2e5fda1a64bcb28964937d661770.xcframework.zip" 
  } 
end
