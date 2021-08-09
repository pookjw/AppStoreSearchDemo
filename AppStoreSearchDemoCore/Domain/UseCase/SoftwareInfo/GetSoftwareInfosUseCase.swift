//
//  GetSoftwareInfosUseCase.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift

public protocol GetSoftwareInfosUseCase {
    func get(text: String) -> Single<[SoftwareInfo]>
}

public final class GetSoftwareInfosUseCaseImpl: GetSoftwareInfosUseCase {
    private let repo: ITSServiceRepository = ITSServiceRepositoryImpl()
    
    public func get(text: String) -> Single<[SoftwareInfo]> {
        repo
            .requestSoftware(text: text)
    }
}
