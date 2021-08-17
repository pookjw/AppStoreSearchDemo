//
//  Localizable.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/17/21.
//

import Foundation

enum Localizable: String {
    case SEARCH
    case RECENTS
    case RESULTS
    
    var string: String {
        NSLocalizedString(rawValue, comment: "")
    }
}
