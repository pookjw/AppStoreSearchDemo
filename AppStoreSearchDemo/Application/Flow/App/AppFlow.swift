//
//  AppFlow.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/10/21.
//

import UIKit
import RxFlow
import RxCocoa
import RxSwift

final class AppFlow: AppServiceFlow {
    var root: Presentable {
        navigationController
    }
    
    let appService: AppService = .init()
    
    private let navigationController: UINavigationController = {
        let nvc: UINavigationController = .init()
        nvc.setNavigationBarHidden(true, animated: false)
        return nvc
    }()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step: AppStep = step as? AppStep else { return .none }
        
        switch step {
        case .pushToTabBar:
            return pushToTabBar()
        }
    }
    
    private func pushToTabBar() -> FlowContributors {
        let flow: TabBarFlow = .init(appService: appService)
        
        Flows.use(flow, when: .created) { [unowned self] root in
            OperationQueue.main.addOperation {
                self.navigationController.pushViewController(root, animated: false)
            }
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: flow,
                                                 withNextStepper: OneStepper(withSingleStep: TabBarStep.setViewControllers)))
    }
}
