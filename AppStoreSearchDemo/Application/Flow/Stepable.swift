//
//  Stepable.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxFlow

protocol Steppable: AnyObject {
    var stepper: Stepper? { get set }
}
