//
//  UICollectionView+register.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit

extension UICollectionView {
    @discardableResult
    func register(_ aClass: AnyClass) -> String {
        let reuseIdentifier: String = String(describing: aClass)
        register(aClass, forCellWithReuseIdentifier: reuseIdentifier)
        return reuseIdentifier
    }
}
