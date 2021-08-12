//
//  SearchItemModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import UIKit.UITableView
import RxDataSources
import AppStoreSearchDemoCore

enum SearchItemModel: IdentifiableType, Equatable {
    case recent(String)
    case result(SoftwareInfo)
    
    var identity: String {
        switch self {
        case .recent(_):
            return UUID().uuidString
        case .result(let info):
            return info.trackId
        }
    }
    
    var height: CGFloat {
        switch self {
        case .recent(_):
            return UITableView.automaticDimension
        case .result(_):
            return 300
        }
    }
    
    static func == (lhs: SearchItemModel, rhs: SearchItemModel) -> Bool {
        switch (lhs, rhs) {
        case (.recent(_), .recent(_)):
            return false
        case (.result(let lhsInfo), .result(let rhsInfo)):
            return lhsInfo == rhsInfo
        default:
            return false
        }
    }
}
