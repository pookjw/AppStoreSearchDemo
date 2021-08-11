//
//  UIViewController+loadFromNib.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import UIKit

extension UIViewController {
    static func loadFromNib(bundle: Bundle? = nil) -> Self {
        return Self.init(nibName: String(describing: self), bundle: bundle)
    }
}
