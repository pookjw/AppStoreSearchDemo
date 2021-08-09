//
//  RecentKeyword.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift

final class RecentKeyword: Object {
    @objc @Persisted(primaryKey: true) dynamic var identity: UUID = .init()
    @objc @Persisted dynamic var keyword: String? = nil
    @objc @Persisted dynamic var timestamp: Date = Date()
    
//    override func isEqual(_ object: Any?) -> Bool {
//        guard let object: RecentKeyword = object as? RecentKeyword else {
//            return super.isEqual(object)
//        }
//        
//        return self.identity == object.identity
//    }
}
