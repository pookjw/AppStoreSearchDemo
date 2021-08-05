//
//  RecentKeyword.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift

final class RecentKeyword: Object {
    @Persisted(primaryKey: true) var identity: UUID = .init()
    @Persisted var keyword: String? = nil
    @Persisted var timestamp: Date = Date()
}
