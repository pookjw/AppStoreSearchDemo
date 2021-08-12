//
//  DetailsPreviewContentView.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit
import Kingfisher

final class DetailsPreviewContentView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL: URL? = nil {
        didSet {
            if let imageURL: URL = imageURL {
                updateImage(imageURL)
            } else {
                imageView.image = nil
            }
        }
    }
    
    private var _configuration: Any?
    
    private func updateImage(_ url: URL) {
        imageView.kf.setImage(with: url)
    }
}

@available(iOS 14.0, *)
extension DetailsPreviewContentView: UIContentView {
    var configuration: UIContentConfiguration {
        get {
            return _configuration as! UIContentConfiguration
        }
        set(newValue) {
            _configuration = newValue
            
            if let previewConfiguration: DetailsPreviewConfiguration = newValue as? DetailsPreviewConfiguration {
                imageURL = previewConfiguration.imageURL
            }
        }
    }
}
