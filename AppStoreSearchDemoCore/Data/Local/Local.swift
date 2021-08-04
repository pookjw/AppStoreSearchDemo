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
    
    func objects(predicate: NSPredicate?) -> Single<[Object]>
    func add(_ object: Object) -> Completable
}
