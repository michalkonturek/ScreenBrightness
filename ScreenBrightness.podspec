
Pod::Spec.new do |s|
  s.name             = 'ScreenBrightness'
  s.version          = '1.0.0'
  s.summary          = 'Provides control and monitoring of screen brightness.'
  s.homepage         = 'https://github.com/michalkonturek/ScreenBrightness'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michal Konturek' => 'michal.konturek@gmail.com' }
  s.source           = { :git => 'https://github.com/michalkonturek/ScreenBrightness.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/michalkonturek'

  s.ios.deployment_target = '8.0'
  s.source_files = 'ScreenBrightness/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
