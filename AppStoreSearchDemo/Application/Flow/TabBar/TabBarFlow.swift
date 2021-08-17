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
                
                let searchTabBarItem: UITabBarItem = .init(title: Localizable.SEARCH.string, image: searchImage, tag: 0)
                
                root.tabBarItem = searchTabBarItem
                self.tabBarController.setViewControllers([root], animated: false)
                
                //
                
                let searchViewController: SearchViewController = .loadFromNib()
                let recentsViewController: RecentsViewController = .loadFromNib()
                let searchController: UISearchController = .init(searchResultsController: searchViewController)
                
                searchController.dimsBackgroundDuringPresentation = false
                recentsViewController.navigationItem.searchController = searchController
                
                searchViewController.loadViewIfNeeded()
                recentsViewController.loadViewIfNeeded()
                
                searchViewController.stepper = searchStepper
                recentsViewController.stepper = searchStepper
                
                nvc.setViewControllers([recentsViewController], animated: false)
                nvc.navigationBar.prefersLargeTitles = true
                
                //
                
                self.appService.searchService
                    .requestSoftwareSearch
                    .bind(to: searchController.searchBar.rx.text)
                    .disposed(by: self.disposeBag)
                
                self.appService.searchService
                    .requestSoftwareSearch
                    .do(afterNext: { [weak searchController] _ in
                        searchController?.isActive = true
                    })
                    .bind(to: searchViewController.viewModel.requestSoftwareSearch)
                    .disposed(by: self.disposeBag)
                
                searchController
                    .searchBar
                    .rx
                    .text
                    .map { $0 ?? "" }
                    .bind(to: searchViewController.viewModel.requestRecentSearch)
                    .disposed(by: self.disposeBag)
                
                searchController
                    .searchBar
                    .rx
                    .searchButtonClicked
                    .withOnlyUnretained(searchController.searchBar)
                    .compactMap { $0.text }
                    .bind(to: searchViewController.viewModel.requestSoftwareSearch)
                    .disposed(by: self.disposeBag)
            }
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: searchFlow, withNextStepper: searchStepper))
    }
}
