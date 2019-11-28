Pod::Spec.new do |s|
  s.name             = 'RxRequester'
  s.version          = '0.4.0'
  s.summary          = 'Simple & Clean RxSwift requester'
  s.description      = <<-DESC
RxRequester abstracts making RxSwift requests and error handling.
DESC

  s.homepage         = 'https://github.com/ShabanKamell/RxRequester-Swift'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'ShabanKamell' => 'sh3ban.kamel@gmail.com' }
  s.source           = { :git => 'https://github.com/ShabanKamell/RxRequester-Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ShaAhKa'

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_version = '5.1.2'
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/RxRequester/**/*"
    ss.framework  = "Foundation"
    ss.dependency "RxSwift", "~> 5.0"
  end

  s.subspec "Alamofire" do |ss|
    ss.source_files  = "Sources/RxRequesterAlamofire/**/*"
    ss.dependency "RxRequester/Core"
    ss.dependency "Alamofire", "~> 5.0.0-rc.3"
 end

  s.subspec "Moya" do |ss|
    ss.source_files  = "Sources/RxRequesterMoya/**/*"
    ss.dependency "RxRequester/Core"
    ss.dependency "Moya/RxSwift", "~> 14.0.0-beta.5"
  end

end
