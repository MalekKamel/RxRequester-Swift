//
// Created by mac on 11/17/19.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import Moya

extension PostsApi: TargetType {

    public var path: String {
        switch self {

        case .posts:
            return "/posts"
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

private func jsonResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch { return data }
}

let postsApi = MoyaProvider<PostsApi>(
        plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: jsonResponseDataFormatter)]
)

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