//
//  AppDelegate.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/4/21.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import AppStoreSearchDemoCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var disposeBag: DisposeBag = .init()
    private var coordinator: FlowCoordinator = .init()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeLog()
        
        let window: UIWindow = .init()
        self.window = window
        
        coordinator.rx
            .willNavigate
            .subscribe(onNext: { (flow, step) in
                log.debug("will navigate to flow=\(flow) and step=\(step)")
            })
            .disposed(by: self.disposeBag)
        
        coordinator.rx
            .didNavigate
            .subscribe(onNext: { (flow, step) in
                log.debug("did navigate to flow=\(flow) and step=\(step)")
            })
            .disposed(by: self.disposeBag)
        
        let appFlow: AppFlow = .init()
        
        coordinator.coordinate(flow: appFlow, with: AppStepper())
        
        Flows.use(appFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
    
}

