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

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple & Clean RxJava requester for Android
DESC

  s.homepage         = 'https://github.com/ShabanKamell/RxRequester-Swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'ShabanKamell' => 'sh3ban.kamel@gmail.com' }
  s.source           = { :git => 'https://github.com/ShabanKamell/RxRequester-iOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ShaAhKa'

  s.ios.deployment_target = '8.0'
  

  s.swift_version = '5.1.2'
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/RxRequester/**/*"
    ss.framework  = "Foundation"
    ss.dependency "RxSwift", "~> 4.0"
  end

  s.subspec "Alamofire" do |ss|
    ss.source_files  = "Sources/RxRequester+Alamofire/**/*"
    ss.dependency "RxRequester/Core"
  end

  s.subspec "Moya" do |ss|
    ss.source_files  = "Sources/RxRequester+Moya/**/*"
    ss.dependency "RxRequester/Core"
    ss.dependency "Moya", "~> 13.0"
  end

end
