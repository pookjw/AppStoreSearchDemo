//
//  RecentsItemModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxDataSources

enum RecentsItemModel: IdentifiableType, Equatable {
    case recent(String)
    
    var identity: String {
        return UUID().uuidString
    }
    
    static func == (lhs: RecentsItemModel, rhs: RecentsItemModel) -> Bool {
        switch (lhs, rhs) {
        case (.recent(_), .recent(_)):
            return false
//        default:
//            return false
        }
    }
}
