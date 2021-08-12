//
//  DetailsIntroContentView.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit
import Kingfisher
import AppStoreSearchDemoCore

final class DetailsIntroContentView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    private var _configuration: Any?
    
    var softwareInfo: SoftwareInfo? {
        didSet {
            if let softwareInfo: SoftwareInfo = softwareInfo {
                updateInfo(softwareInfo)
            }
        }
    }
    
    private func updateInfo(_ softwareInfo: SoftwareInfo) {
        imageView.kf.setImage(with: softwareInfo.artworkUrl512)
        primaryLabel.text = softwareInfo.trackName
        secondaryLabel.text = softwareInfo.sellerName
    }
}

@available(iOS 14.0, *)
extension DetailsIntroContentView: UIContentView {
    var configuration: UIContentConfiguration {
        get {
            return _configuration as! UIContentConfiguration
        }
        set(newValue) {
            _configuration = newValue
            
            if let softwareInfoConfiguration: DetailsIntroConfiguration = newValue as? DetailsIntroConfiguration {
                softwareInfo = softwareInfoConfiguration.softwareInfo
            }
        }
    }
}
