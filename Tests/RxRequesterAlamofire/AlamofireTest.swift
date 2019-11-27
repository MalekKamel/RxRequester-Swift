//
//  RxRequesterAlamofireTest.swift
//  RxRequesterAlamofireTests
//
//  Created by mac on 11/23/19.
//  Copyright © 2019 sha. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
import Alamofire
@testable import RxRequester
@testable import RxRequesterAlamofire

class AlamofireTest: XCTestCase {
    var requester: RxRequester!
    var presentable: MockPresentable!

    override func setUp() {
        presentable = MockPresentable()
        requester = RxRequester(presentable: presentable)
        AlamofireHandlers.statusCodeHandlers = [BadRequestHandler()]
        AlamofireHandlers.underlyingErrorHandlers = [MyUnderlyingErrorHandler()]
        AlamofireHandlers.errorHandlers = [JsonSerializationFailedHandler()]
    }

    func testStatusCodeHandlers() {
        let error = AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.unacceptableStatusCode(code: 400))
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .single()
        XCTAssertEqual(presentable.errorMessage, "BadRequestHandler")
    }

    func testUnderlyingHandlers() {
        let error = AFError.parameterEncodingFailed(reason: AFError.ParameterEncodingFailureReason.jsonEncodingFailed(error: MyUnderlyingError()))
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "MyUnderlyingErrorHandler")
    }

    func testErrorHandlers() {
        let error = AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.jsonSerializationFailed(error: JsonSerializationFailedError()))
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "JsonSerializationFailedHandler")
    }
}

class MyUnderlyingError: Error {}
class JsonSerializationFailedError: Error {}
