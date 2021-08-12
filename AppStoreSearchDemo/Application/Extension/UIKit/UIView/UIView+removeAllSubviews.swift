//
//  UIView+removeAllSubviews.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
