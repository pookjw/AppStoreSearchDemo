//
//  ObserveRecentKeywordUseCase.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift

public protocol ObserveRecentKeywordUseCase {
    func observe() -> Observable<[String]>
}

public final class ObserveRecentKeywordUseCaseImpl: ObserveRecentKeywordUseCase {
    private let repo: RecentKeywordRepository = RecentKeywordRepositoryImpl()
    
    public func observe() -> Observable<[String]> {
        repo
            .observe()
            .map { $0.compactMap { $0.keyword} }
    }
}
