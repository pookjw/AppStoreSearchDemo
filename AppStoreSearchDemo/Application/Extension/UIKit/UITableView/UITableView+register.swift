//
//  UITableView+register.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/12/21.
//

import UIKit

extension UITableView {
    @discardableResult
    func register(_ aClass: AnyClass) -> String {
        let reuseIdentifier: String = String(describing: aClass)
        register(aClass, forCellReuseIdentifier: reuseIdentifier)
        return reuseIdentifier
    }
}
