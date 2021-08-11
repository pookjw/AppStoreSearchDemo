//
//  DetailsStepper.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

final class DetailsStepper: Stepper {
    var steps: PublishRelay<Step> = .init()
}
