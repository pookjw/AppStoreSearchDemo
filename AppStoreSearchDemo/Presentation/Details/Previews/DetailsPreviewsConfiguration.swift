//
//  DetailsPreviewsConfiguration.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit
import AppStoreSearchDemoCore

@available(iOS 14.0, *)
struct DetailsPreviewsConfiguration: UIContentConfiguration {
    let softwareInfo: SoftwareInfo
    
    func makeContentView() -> UIView & UIContentView {
        let contentView: DetailsPreviewsContentView = .loadFromNib()
        contentView.configuration = self
        return contentView
    }
    
    func updated(for state: UIConfigurationState) -> DetailsPreviewsConfiguration {
        self
    }
}
