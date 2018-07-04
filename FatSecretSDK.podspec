Pod::Spec.new do |s|
  s.name     = 'FatSecretSDK'
  s.version  = '1.0'
  s.author   = 'larryonoff'
  s.homepage = 'https://gitlab.com/larryonoff/fatsecret-ios-sdk'
  s.summary  = 'FatSecret iOS SDK on Swift'
  s.cocoapods_version = '>= 1.0'

  s.source = { :git => 'https://gitlab.com/larryonoff/fatsecret-ios-sdk',
               :tag => s.version }

  s.source_files = 'Sources/**/*.{h,m,swift}'
  s.public_header_files = 'Sources/**/*.h'

  s.requires_arc = true

  s.ios.deployment_target = '10.0'

  s.ios.dependency 'Result', '~> 3.2'
  s.ios.dependency 'OAuthSwift', '~> 1.2'
end
