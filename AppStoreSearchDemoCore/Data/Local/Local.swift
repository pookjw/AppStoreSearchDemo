//
//  Local.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift
import RxSwift

protocol Local {
    associatedtype Object: RealmSwift.Object
    
    // Read
    func objects(predicate: NSPredicate?) -> Single<[Object]>
    
    // Create
    func new(block: @escaping ((Object) -> ())) -> Single<Object>
    
    // Modify
    func modify(_ object: Object, block: @escaping ((Object) -> ())) -> Completable
    
    // Delete
    func delete(_ object: Object) -> Completable
}
