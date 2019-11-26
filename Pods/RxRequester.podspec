#
# Be sure to run `pod lib lint RxRequester.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxRequester'
  s.version          = '0.1.0'
  s.summary          = 'Simple & Clean RxJava requester for Android'
  s.description      = <<-DESC
Simple & Clean RxJava requester for Android
DESC

  s.homepage         = 'https://github.com/ShabanKamell/RxRequester-Swift'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'ShabanKamell' => 'sh3ban.kamel@gmail.com' }
  s.source           = { :git => 'https://github.com/ShabanKamell/RxRequester-iOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ShaAhKa'
  s.swift_version = '5.1.2'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

  s.default_subspec = "Core"
  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/RxRequester/**/*"
    ss.exclude_files = "Sources/RxRequester/Tests/**/*"
    ss.framework  = "Foundation"
    ss.dependency "RxSwift", "~> 4.0"
  end

  s.subspec "Alamofire" do |ss|
    ss.source_files  = "Sources/RxRequester+Alamofire/**/*"
    ss.exclude_files = "Sources/RxRequester+Alamofire/Tests/**/*"
    ss.dependency "RxRequester/Core"
     ss.dependency "Alamofire", "~> 4.1"
 end

  s.subspec "Moya" do |ss|
    ss.source_files  = "Sources/RxRequester+Moya/**/*"
    ss.exclude_files = "Sources/RxRequester+Moya/Tests/**/*"
    ss.dependency "RxRequester/Core"
    ss.dependency "Moya", "~> 13.0"
  end

end
