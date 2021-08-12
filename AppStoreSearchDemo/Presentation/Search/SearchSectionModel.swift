//
//  SearchSectionModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxDataSources

enum SearchSectionModel: Int, IdentifiableType, Equatable {
    case recents
    case results
    
    var identity: Int {
        return rawValue
    }
    
    static func == (lhs: SearchSectionModel, rhs: SearchSectionModel) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
