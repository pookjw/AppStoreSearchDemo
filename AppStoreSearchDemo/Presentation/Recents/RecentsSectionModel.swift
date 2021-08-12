//
//  RecentsSectionModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxDataSources

enum RecentsSectionModel: Int, IdentifiableType, Equatable {
    case recents
    
    var identity: Int {
        return rawValue
    }
    
    static func == (lhs: RecentsSectionModel, rhs: RecentsSectionModel) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
