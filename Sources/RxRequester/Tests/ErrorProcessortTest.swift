//
//  ErrorProcessotTest.swift
//  RxRequesterTests
//
//  Created by mac on 11/24/19.
//  Copyright © 2019 sha. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxRequester

class ErrorProcessortTest: XCTestCase {

    var requester: RxRequester!
    var presentable: MockPresentable!
    var scheduler: TestScheduler!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        presentable = MockPresentable()
        requester = RxRequester(presentable: presentable)
        RxRequester.nsErrorHandlers = [ConnectivityHandler()]
        RxRequester.errorHandlers = [MyErrorHandler()]
        RxRequester.resumableHandlers = [UnauthorizedHandler()]
    }

    func testProcess_throwNSError() {
        let error = NSError(domain: "test", code: NSURLErrorNotConnectedToInternet)
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "ConnectivityHandler")
    }

    func testProcess_throwUnknownError() {
        let error = NSError(domain: "test", code: 444)
        _ = try? requester.request(request: { Observable<String>.error(error) })
                .toBlocking()
                .first()
        XCTAssert(presentable.isOnHandleErrorFailedCalled)
    }

    func testProcess_testResumableHandlers() {
        _ = try? requester.request(request: { Observable<String>.error(UnauthorizedError()) })
                .toBlocking()
                .first()

        XCTAssertEqual(presentable.errorMessage, "UnauthorizedHandler")
    }

    func testProcess_testErrorHandlers() {
        _ = try? requester.request(request: { Observable<String>.error(MyError()) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "MyErrorHandler")
    }

    func testProcess_testHTTPURLResponseHandlers() {
        _ = try? requester.request(request: { Observable<String>.error(MyError()) })
                .toBlocking()
                .first()
        XCTAssertEqual(presentable.errorMessage, "MyErrorHandler")
    }
}

class MyError: Error {}
class UnauthorizedError: Error {}