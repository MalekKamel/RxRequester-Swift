platform :ios, '11.0'

def alamofire
  pod 'Alamofire', '~> 5.0.0-rc.3'
end

def rxSwift
  pod 'RxSwift', '~> 5.0'
end

def moya
  pod 'Moya/RxSwift', '~> 14.0.0-beta.5'
end

def examples_pods
  rxSwift
  pod 'SwiftMessages'
end

def test_pods
  pod 'RxTest'
  pod 'RxBlocking'
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