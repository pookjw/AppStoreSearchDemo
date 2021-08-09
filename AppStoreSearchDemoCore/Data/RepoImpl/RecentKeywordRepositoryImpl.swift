//
//  RecentKeywordRepositoryImpl.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift

final class RecentKeywordRepositoryImpl: RecentKeywordRepository {
    private let localRealm: LocalRealm = LocalRealmImpl()
    
    func getList() -> Single<[RecentKeyword]> {
        localRealm
            .objects(predicate: nil, sortKV: #keyPath(RecentKeyword.keyword), ascending: false)
    }
    
    func create(block: @escaping ((RecentKeyword) -> ())) -> Single<RecentKeyword> {
        localRealm
            .create(block: block)
    }
    
    func observe() -> Observable<[RecentKeyword]> {
        localRealm
            .observe(type: RecentKeyword.self)
            .withUnretained(self)
            .flatMap { (weakSelf, _) -> Observable<[RecentKeyword]> in
                weakSelf
                    .getList()
                    .asObservable()
            }
    }
}
