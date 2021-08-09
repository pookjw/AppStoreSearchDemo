//
//  SoftwareInfoDTOTest.swift
//  AppStoreSearchDemoCoreTests
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import XCTest
@testable import AppStoreSearchDemoCore

final class SoftwareInfoDTOTest: XCTestCase {
    func testConversion() {
        do {
            guard let url: URL = Bundle(identifier: "com.pookjw.AppStoreSearchDemoCore")?.url(forResource: "software_request_data_example", withExtension: "json") else {
                XCTFail("software_request_data_example.json does not exist!")
                return
            }
            
            let data: Data = try .init(contentsOf: url)
            
            let infos: [SoftwareInfo] = try SoftwareInfo.fromData(data)
            
            guard infos.count == 1 else {
                XCTFail("data is corrupted!")
                return
            }
            
            XCTAssertEqual(infos[0].trackName, "DoroDoro - Korean Address")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSample() {
        let info: SoftwareInfo = .sample
        XCTAssertEqual(info.trackName, "DoroDoro - Korean Address")
    }
}
