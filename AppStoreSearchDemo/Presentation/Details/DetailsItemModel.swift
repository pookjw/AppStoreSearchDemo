//
//  DetailsItemModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxDataSources
import AppStoreSearchDemoCore

enum DetailsItemModel: IdentifiableType, Equatable {
    case intro(SoftwareInfo)
    case previews(SoftwareInfo)
    
    var identity: Int {
        switch self {
        case .intro(_):
            return 0
        case .previews(_):
            return 1
        }
    }
    
    var height: CGFloat {
        switch self {
        case .intro(_):
            return 150
        case .previews(_):
            return 400
        }
    }
    
    static func == (lhs: DetailsItemModel, rhs: DetailsItemModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
