//
//  CreateRecentKeywordUseCase.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RxSwift

public protocol CreateRecentKeywordUseCase {
    func create(text: String) -> Completable
}

public final class CreateRecentKeywordUseCaseImpl: CreateRecentKeywordUseCase {
    private let repo: RecentKeywordRepository = RecentKeywordRepositoryImpl()
    
    public func create(text: String) -> Completable {
        repo
            .create { new in
                new.keyword = text
            }
            .asCompletable()
    }
}
