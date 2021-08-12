//
//  DetailsPreviewsItemModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxDataSources

enum DetailsPreviewsItemModel: IdentifiableType, Equatable {
    case image(URL)
    
    var identity: String {
        switch self {
        case .image(let url):
            return url.absoluteString
        }
    }
    
    static func == (lhs: DetailsPreviewsItemModel, rhs: DetailsPreviewsItemModel) -> Bool {
        return lhs.identity == rhs.identity
    }
}
