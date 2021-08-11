//
//  SearchFlow.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import AppStoreSearchDemoCore

final class SearchFlow: AppServiceFlow {
    var root: Presentable {
        rootViewController
    }
    
    let appService: AppService
    
    private let rootViewController: UINavigationController = .init()
    
    init(appService: AppService) {
        self.appService = appService
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step: SearchStep = step as? SearchStep else { return .none }
        
        switch step {
        case .requestSearch(let text):
            return requestSearch(text: text)
        case .pushToDetails(let info):
            return pushToDetails(info: info)
        }
    }
    
    private func requestSearch(text: String) -> FlowContributors {
        appService.searchService
            .requestSearch
            .accept(text)
        
        return .none
    }
    
    private func pushToDetails(info: SoftwareInfo) -> FlowContributors {
        let flow: DetailsFlow = .init(appService: appService)
        let stepper: DetailsStepper = .init()
        
        Flows.use(flow, when: .created) { [weak self] root in
            if let root: Steppable = root as? Steppable {
                root.stepper = stepper
            }
            
            root.loadViewIfNeeded()
            
            if let details: DetailsViewController = root as? DetailsViewController {
                details.viewModel.requestDataSource.accept(info)
            }
            
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: stepper))
    }
}
