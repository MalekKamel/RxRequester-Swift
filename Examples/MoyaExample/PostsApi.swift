//
// Created by mac on 11/17/19.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension PostsApi: TargetType {

    public var path: String {
        switch self {
        case .posts:
            return Defaults.shared.endpoint.rawValue
        }
    }

    public var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .posts:
            var parameters = [String: Any]()
            parameters["_limit"] = "100"
            parameters["_start"] = "0"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    public var validationType: ValidationType { .none }
    public var sampleData: Data { Data() }
    public var headers: [String: String]? {  nil }
    public var parameters: [String: Any]? { nil }

}

// MARK: - Response Handlers

private func jsonResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(decoding: prettyData, as: UTF8.self)
    } catch { return String(decoding: data, as: UTF8.self) }
}

let postsApi = createProvider()

private func createProvider() -> MoyaProvider<PostsApi> {
    var config = NetworkLoggerPlugin.Configuration()

    // Log Options
    var logOptions = NetworkLoggerPlugin.Configuration.LogOptions()
    logOptions.insert(NetworkLoggerPlugin.Configuration.LogOptions.verbose)
    config.logOptions = logOptions

    // Formatter
    config.formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: jsonResponseDataFormatter)

    let logger = NetworkLoggerPlugin(configuration: config)

    return MoyaProvider<PostsApi>(plugins: [logger])
}

enum PostsApi {
    case posts
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

private extension String {
    var urlEscaped: String { self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! }
}

public func url(_ route: TargetType) -> String {
    route.baseURL.appendingPathComponent(route.path).absoluteString
}

public extension Reactive where Base: MoyaProviderType {
    func requestMappingSuccess(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        request(token, callbackQueue: callbackQueue).map({ response in
            guard (200...299).contains(response.statusCode)
                    else {
                throw MoyaError.statusCode(response)
            }
            return response
        })
    }
}
