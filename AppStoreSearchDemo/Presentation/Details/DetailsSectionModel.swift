//
//  DetailsSectionModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxDataSources

enum DetailsSectionModel: Int, IdentifiableType, Equatable {
    case noname
    
    var identity: Int {
        return rawValue
    }
    
    static func == (lhs: DetailsSectionModel, rhs: DetailsSectionModel) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
