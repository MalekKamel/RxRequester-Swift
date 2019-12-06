//
//  RxRequesterTest.swift
//  RxRequesterTests
//
//  Created by mac on 11/23/19.
//  Copyright © 2019 sha. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import RxRequester

class RxRequesterTest: XCTestCase {
    var requester: RxRequester!
    var presentable: MockPresentable!
    var scheduler: TestScheduler!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        presentable = MockPresentable()
        requester = RxRequester(presentable: presentable)
    }

    func testRequest_succeedsAndLoadingToggles() {
        let result = try! requester.request(request: { Observable.just("foo") })
                .toBlocking()
                .single()
        XCTAssertEqual(result, "foo")
        XCTAssert(presentable.isShowLoadingCalled)
        XCTAssert(presentable.isHideLoadingCalled)
    }

    func testRequestSingle_succeedsAndLoadingToggles() {
        let result = try! requester.request(singleRequest: { Single.just("foo") })
                .toBlocking()
                .single()
        XCTAssertEqual(result, "foo")
        XCTAssert(presentable.isShowLoadingCalled)
        XCTAssert(presentable.isHideLoadingCalled)
    }

    func testRequestCompletable_succeedsAndLoadingToggles() {
        let result = try! requester.request(singleRequest: { Single.just("foo") })
                .toBlocking()
                .single()
        XCTAssertEqual(result, "foo")
        XCTAssert(presentable.isShowLoadingCalled)
        XCTAssert(presentable.isHideLoadingCalled)
    }

}
