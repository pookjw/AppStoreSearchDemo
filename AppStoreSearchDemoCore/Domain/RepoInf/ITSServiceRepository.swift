//
//  ITSServiceRepository.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift

protocol ITSServiceRepository {
    func requestSoftware(text: String) -> Single<[SoftwareInfo]>
}
