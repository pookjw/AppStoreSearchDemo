//
//  Local.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift
import RxSwift

enum LocalError: Error, LocalizedError {
    case realmThreadSolveFailed
    
    var errorDescription: String? {
        switch self {
        case .realmThreadSolveFailed:
            return "RealmStore Solve 에러 (번역)"
        }
    }
}

protocol Local {
    associatedtype Object: RealmSwift.Object
    
    // Read
    func objects(predicate: NSPredicate?) -> Single<[Object]>
    
    // Create
    func create(block: @escaping ((Object) -> ())) -> Single<Object>
    
    // Modify
    func modify(_ object: Object, block: @escaping ((Object) -> ())) -> Completable
    
    // Delete
    func delete(_ object: Object) -> Completable
    
    // Observe
    func observe() -> Observable<Void>
}
