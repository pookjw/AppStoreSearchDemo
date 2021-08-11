//
//  RecentsViewController.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class RecentsViewController: UIViewController {
    private(set) var viewModel: RecentsViewModel! = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    
}
