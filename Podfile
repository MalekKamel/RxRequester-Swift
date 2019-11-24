# platform :ios, '9.0'

def examples_pods
  pod 'RxSwift', '~> 4.0'
  pod 'SwiftMessages', '6.0.1'
  pod 'Alamofire', '~> 4.1'
end

def test_pods
  pod 'RxTest'
  pod 'RxBlocking'
  pod 'Quick'
  pod 'Nimble'
end

target 'AlamofireExample' do
  use_frameworks!
  examples_pods
end

target 'MoyaExample' do
  use_frameworks!
  examples_pods
end

target 'RxRequester' do
  use_frameworks!
  pod 'RxSwift', '~> 4.0'

  target 'RxRequesterTests' do
    test_pods
  end

end

target 'RxRequesterAlamofire' do
  use_frameworks!
  pod 'Alamofire', '~> 4.1'

  target 'RxRequesterAlamofireTests' do
    test_pods
  end

end

target 'RxRequesterMoya' do
  use_frameworks!
  pod 'Moya/RxSwift', '~> 13.0.0'

  target 'RxRequesterMoyaTests' do
    test_pods
  end

end