//
//  LocalRealm.swift
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

protocol LocalRealm {
    // Read
    func objects<T: Object>(predicate: NSPredicate?) -> Single<[T]>
    
    // Read with sort
    func objects<T: Object>(predicate: NSPredicate?, sortKV: String, ascending: Bool) -> Single<[T]>
    
    // Create with thread-safe pool
    func create<T: Object>(block: @escaping ((T) -> ())) -> Single<T>
    
    // Modify with thread-safe pool
    func modify<T: Object>(_ object: T, block: @escaping ((T) -> ())) -> Single<T>
    
    // Delete
    func delete<T: Object>(_ object: T) -> Completable
    
    // Observe
    func observe(type: Object.Type) -> Observable<Void>
}
