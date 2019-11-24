# platform :ios, '9.0'

def alamofire
  pod 'Alamofire', '~> 4.1'
end

def rxSwift
  pod 'RxSwift', '~> 4.0'
end

def moya
  pod 'Moya/RxSwift', '~> 13.0.0'
end

def examples_pods
  rxSwift
  pod 'SwiftMessages', '6.0.1'
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
  alamofire
end

target 'MoyaExample' do
  use_frameworks!
  examples_pods
  moya
end

target 'RxRequester' do
  use_frameworks!
  rxSwift

  target 'RxRequesterTests' do
    test_pods
  end

end

target 'RxRequesterAlamofire' do
  use_frameworks!
  alamofire

  target 'RxRequesterAlamofireTests' do
    test_pods
  end

end

target 'RxRequesterMoya' do
  use_frameworks!
  moya

  target 'RxRequesterMoyaTests' do
    test_pods
  end

end