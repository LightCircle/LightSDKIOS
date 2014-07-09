Pod::Spec.new do |s|
  s.name             = "LightSDK"
  s.version          = "0.0.1"
  s.summary          = "iOS SDK for Light."
  s.description      = <<-DESC
                       iOS SDK for Light.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://www.alphabets.com.cn"
  s.screenshots      = "http://www.alphabets.com.cn/images/content/hi_1.png", "http://www.alphabets.com.cn/images/content/hi_4.jpg"
  s.license          = 'MIT'
  s.author           = { "fzcs" => "fzcs@live.cn" }
  #s.source          = { :git => "https://github.com/fzcs/LightSDK.git", :tag => s.version.to_s }
  s.source           = { :git => "https://github.com/LightCircle/LightSDKIOS.git" }
  s.social_media_url = 'http://www.alphabets.cn'

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'LightSDK/LightSDK.h'

  s.subspec 'Entity' do |ss|
    ss.source_files = 'LightSDK/Entity/**/*.{h,m}'
  end

  s.subspec 'Logger' do |ss|
    ss.source_files = 'LightSDK/Logger/**/*.{h,m}'
  end

  s.subspec 'Rest' do |ss|
    ss.source_files = 'LightSDK/Rest/**/*.{h,m}'
  end

  s.subspec 'Storable' do |ss|
    ss.source_files = 'LightSDK/Storable/**/*.{h,m}'
  end

  s.subspec 'Util' do |ss|
    ss.source_files = 'LightSDK/Util/**/*.{h,m}'
  end

  s.subspec 'WebSocket' do |ss|
    ss.source_files = 'LightSDK/WebSocket/**/*.{h,m}'
  end

  s.subspec 'Config' do |ss|
    ss.source_files = 'LightSDK/Config/**/*.{h,m}'
  end

  s.subspec 'UI' do |ss|
    ss.source_files = 'LightSDK/UI/**/*.{h,m}'
  end


  s.dependency 'AFNetworking',               '2.2.4'
  s.dependency 'AFNetworking-RACExtensions', '0.1.4'
  s.dependency 'jastor',                     '0.2.1'
  s.dependency 'CocoaLumberjack',            '1.8.1'
  s.dependency 'ReactiveCocoa',              '2.3'
  s.dependency 'libextobjc',                 '0.4'
  s.dependency 'SocketRocket',               '0.3.1-beta2'
  s.dependency 'SDWebImage',                 '3.6'
  s.dependency 'Underscore.m',               '0.2.1'
  
end
