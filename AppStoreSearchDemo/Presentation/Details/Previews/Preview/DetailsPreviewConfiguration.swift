//
//  DetailsPreviewConfiguration.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit

@available(iOS 14.0, *)
struct DetailsPreviewConfiguration: UIContentConfiguration {
    let imageURL: URL
    
    func makeContentView() -> UIView & UIContentView {
        let contentView: DetailsPreviewContentView = .loadFromNib()
        contentView.configuration = self
        return contentView
    }
    
    func updated(for state: UIConfigurationState) -> DetailsPreviewConfiguration {
        return self
    }
}
