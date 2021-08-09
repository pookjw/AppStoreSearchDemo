//
//  ITSServiceNetworkTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import XCTest
import RxSwift
@testable import AppStoreSearchDemoCore

final class ITSServiceNetworkTest: XCTestCase {
    private let network: Network = NetworkImpl()
    private var disposeBag: DisposeBag = .init()
    
    override func setUp() {
        super.setUp()
        initializeLog()
    }
    
    func testSoftwareRequest() {
        let expectation: XCTestExpectation = .init()
        
        network
            .request(ITSServiceType.software("DoroDoro"))
            .subscribe { data in
                guard let string: String = String(data: data, encoding: .utf8) else {
                    XCTFail("unicode error!")
                    return
                }
                log.info(string)
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testLookupRequest() {
        let expectation: XCTestExpectation = .init()
        
        network
            .request(ITSServiceType.lookup("1557114617"))
            .subscribe { data in
                guard let string: String = String(data: data, encoding: .utf8) else {
                    XCTFail("unicode error!")
                    return
                }
                log.info(string)
                expectation.fulfill()
            } onFailure: { error in
                XCTFail(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}
