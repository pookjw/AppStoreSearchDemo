//
//  ITSServiceRepositoryImpl.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift
import Moya

final class ITSServiceRepositoryImpl: ITSServiceRepository {
    private let network: Network = NetworkImpl()
    
    func requestSoftware(text: String) -> Single<[SoftwareInfo]> {
        network
            .request(ITSServiceType.software(text))
            .map { data -> [SoftwareInfo] in
                try SoftwareInfo.fromData(data)
            }
    }
}
