//
//  DetailsFlow.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxFlow

final class DetailsFlow: AppServiceFlow {
    var root: Presentable {
        rootViewController
    }
    
    let appService: AppService
    
    private var rootViewController: UIViewController = DetailsViewController.loadFromNib()
    
    init(appService: AppService) {
        self.appService = appService
    }
    
    func navigate(to step: Step) -> FlowContributors {
        .none
    }
    
    
}
