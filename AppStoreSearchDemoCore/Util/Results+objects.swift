//
//  Results+objects.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift

extension Results {
    var objects: [Element] {
        let indexes: IndexSet = .init(integersIn: 0..<count)
        return objects(at: indexes)
    }
}
