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
}
