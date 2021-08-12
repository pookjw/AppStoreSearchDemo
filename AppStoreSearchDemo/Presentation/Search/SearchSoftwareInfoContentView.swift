//
//  SearchSoftwareInfoContentView.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit
import Kingfisher
import AppStoreSearchDemoCore

final class SearchSoftwareInfoContentView: UIView {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    private var _configuration: Any?

    var softwareInfo: SoftwareInfo? {
        didSet {
            if let softwareInfo: SoftwareInfo = softwareInfo {
                updateInfo(softwareInfo)
            }
        }
    }
    
    private func updateInfo(_ softwareInfo: SoftwareInfo) {
        mainImageView.kf.setImage(with: softwareInfo.artworkUrl100)
        
        primaryLabel.text = softwareInfo.trackName
        secondaryLabel.text = softwareInfo.sellerName
        
        let previews: [URL] = softwareInfo.screenshotUrls.compactMap { $0 }
        
        if previews.count > 0 {
            firstImageView.kf.setImage(with: previews[0])
        }
        if previews.count > 1 {
            secondImageView.kf.setImage(with: previews[1])
        }
        if previews.count > 2 {
            thirdImageView.kf.setImage(with: previews[2])
        }
    }
}

@available(iOS 14.0, *)
extension SearchSoftwareInfoContentView: UIContentView {
    var configuration: UIContentConfiguration {
        get {
            return _configuration as! UIContentConfiguration
        }
        set(newValue) {
            _configuration = newValue
            
            if let softwareInfoConfiguration: SearchSoftwareInfoConfiguration = newValue as? SearchSoftwareInfoConfiguration {
                softwareInfo = softwareInfoConfiguration.softwareInfo
            }
        }
    }
}
