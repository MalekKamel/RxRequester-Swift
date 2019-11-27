//
// Created by mac on 11/24/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxRequester
@testable import RxRequesterMoya
@testable import Moya

class MoyaTest: XCTestCase {
    var requester: RxRequester!
    var presentable: MockPresentable!

    override func setUp() {
        presentable = MockPresentable()
        requester = RxRequester(presentable: presentable)
        MoyaHandlers.statusCodeHandlers = [BadRequestHandler()]
        MoyaHandlers.underlyingErrorHandlers = [MyUnderlyingErrorHandler()]
        MoyaHandlers.errorHandlers = [EncodableMappingErrorHandler()]
    }

    func testStatusCodeHandlers() {
        let error = MoyaError.statusCode(Response(statusCode: 400, data: Data()))
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "BadRequestHandler")
    }

    func testUnderlyingHandlers() {
        let error = MoyaError.underlying(MyUnderlyingError(), Response(statusCode: 400, data: Data()))
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "MyUnderlyingErrorHandler")
    }

    func testErrorHandlers() {
        let error = MoyaError.encodableMapping(EncodableMappingError())
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "EncodableMappingErrorHandler")
    }
}

class MyUnderlyingError: Error {}
class EncodableMappingError: Error {}

