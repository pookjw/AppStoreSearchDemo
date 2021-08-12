//
//  UITableViewCell+reuseIdentifier.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/12/21.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}
