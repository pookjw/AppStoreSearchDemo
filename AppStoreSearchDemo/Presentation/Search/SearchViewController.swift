//
//  SearchViewController.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow
import AppStoreSearchDemoCore

final class SearchViewController: UIViewController, Steppable {
    var stepper: Stepper?
    private(set) var viewModel: SearchViewModel! = .init()
    private var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        
        viewModel
            .requestSearch
            .subscribe(onNext: { text in
                log.info(text)
            })
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.stepper?.steps.accept(SearchStep.pushToDetails(.sample))
        }
    }
}
