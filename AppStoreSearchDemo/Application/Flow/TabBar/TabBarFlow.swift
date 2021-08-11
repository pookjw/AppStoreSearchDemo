//
//  TabBarFlow.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/10/21.
//

import UIKit
import RxFlow
import RxSwift

final class TabBarFlow: AppServiceFlow {
    var root: Presentable {
        tabBarController
    }
    
    let appService: AppService
    
    private let tabBarController: UITabBarController = .init()
    private var disposeBag: DisposeBag = .init()
    
    init(appService: AppService) {
        self.appService = appService
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step: TabBarStep = step as? TabBarStep else { return .none }
        
        switch step {
        case .setViewControllers:
            return setViewControllers()
        }
    }
    
    private func setViewControllers() -> FlowContributors {
        let searchStepper: SearchStepper = .init()
        
        let searchFlow: SearchFlow = .init(appService: appService)
        
        Flows.use(searchFlow, when: .created) { [weak self] root in
            guard let self = self else { return }
            
            if let nvc: UINavigationController = root as? UINavigationController {
                var searchImage: UIImage?
                if #available(iOS 13.0, *) {
                    searchImage = UIImage(systemName: "magnifyingglass")
                }
                
                let searchTabBarItem: UITabBarItem = .init(title: "Search (번역)", image: searchImage, tag: 0)
                
                root.tabBarItem = searchTabBarItem
                self.tabBarController.setViewControllers([root], animated: false)
                
                //
                
                let recentsViewController: RecentsViewController = .loadFromNib()
                let searchController: UISearchController = .init(searchResultsController: recentsViewController)
                let searchViewController: SearchViewController = .loadFromNib()
                
                searchViewController.navigationItem.searchController = searchController
                
                searchViewController.loadViewIfNeeded()
                recentsViewController.loadViewIfNeeded()
                
                searchViewController.stepper = searchStepper
                recentsViewController.stepper = searchStepper
                
                nvc.setViewControllers([searchViewController], animated: false)
                
                //
                
                self.appService.searchService
                    .requestSearch
                    .bind(to: searchViewController.viewModel.requestSearch)
                    .disposed(by: self.disposeBag)
                
                recentsViewController.viewModel
                    .requestSearch
                    .bind(to: self.appService.searchService.requestSearch)
                    .disposed(by: self.disposeBag)
            }
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: searchFlow, withNextStepper: searchStepper))
    }
}
