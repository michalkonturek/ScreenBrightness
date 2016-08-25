
Pod::Spec.new do |s|
  s.name             = 'ScreenBrightness'
  s.version          = '1.1.0'
  s.summary          = 'ScreenBrightness allows you to monitor brightness of your device screen without a hassle.'
  s.homepage         = 'https://github.com/michalkonturek/ScreenBrightness'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michal Konturek' => 'michal.konturek@gmail.com' }
  s.source           = { :git => 'https://github.com/michalkonturek/ScreenBrightness.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/michalkonturek'
  
  s.ios.deployment_target = '8.0'
  s.source_files = 'ScreenBrightness/Classes/**/*'
end
