//
//  GetRecentKeywordUseCase.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift

public protocol GetRecentKeywordUseCase {
    func getList() -> Single<[String]>
}

public final class GetRecentKeywordUseCaseImpl: GetRecentKeywordUseCase {
    private let repo: RecentKeywordRepository = RecentKeywordRepositoryImpl()
    
    public init() {}
    
    public func getList() -> Single<[String]> {
        repo
            .getList()
            .map { $0.compactMap { $0.keyword } }
    }
}
