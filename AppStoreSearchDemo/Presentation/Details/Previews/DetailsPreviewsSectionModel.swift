//
//  DetailsPreviewsSectionModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxDataSources

enum DetailsPreviewsSectionModel: Int, IdentifiableType, Equatable {
    case noname
    
    var identity: Int {
        return rawValue
    }
    
    static func == (lhs: DetailsPreviewsSectionModel, rhs: DetailsPreviewsSectionModel) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
