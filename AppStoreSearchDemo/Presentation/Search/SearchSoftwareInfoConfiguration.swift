//
//  SearchSoftwareInfoConfiguration.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit
import AppStoreSearchDemoCore

@available(iOS 14.0, *)
struct SearchSoftwareInfoConfiguration: UIContentConfiguration {
    let softwareInfo: SoftwareInfo
    
    func makeContentView() -> UIView & UIContentView {
        let contentView: SearchSoftwareInfoContentView = .loadFromNib()
        contentView.configuration = self
        return contentView
    }
    
    func updated(for state: UIConfigurationState) -> SearchSoftwareInfoConfiguration {
        return self
    }
}
