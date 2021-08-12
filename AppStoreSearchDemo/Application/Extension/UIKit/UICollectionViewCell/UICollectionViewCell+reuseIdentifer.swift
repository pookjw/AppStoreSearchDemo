//
//  UICollectionViewCell+reuseIdentifer.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}

