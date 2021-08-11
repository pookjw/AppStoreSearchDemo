//
//  AppStepper.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/10/21.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

final class AppStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    private var disposeBag: DisposeBag = .init()
    
    var initialStep: Step {
        return AppStep.pushToTabBar
    }
    
    func readyToEmitSteps() {
        
    }
}
