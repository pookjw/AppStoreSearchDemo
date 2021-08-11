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
import RxDataSources
import AppStoreSearchDemoCore

final class SearchViewController: UIViewController, Steppable {
    var stepper: Stepper?
    private(set) var viewModel: SearchViewModel!
    private var disposeBag: DisposeBag = .init()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        configureViewModel()
        bind()
    }
    
    private func setAttributes() {
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "검색 (번역)"
    }
    
    private func configureViewModel() {
        let viewModel: SearchViewModel = .init(dataSource: <#T##SearchViewModel.DataSource#>)
        self.viewModel = viewModel
    }
    
    private func bind() {
        viewModel
            .requestSearch
            .subscribe(onNext: { text in
                log.info(text)
            })
            .disposed(by: disposeBag)
    }
    
    private func makeDataSource() -> SearchViewModel.DataSource {
        let dataSource: SearchViewModel.DataSource = .init { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#>, <#UITableView#>, <#IndexPath#>, <#TableViewSectionedDataSource<SearchViewModel.SectionModel>.Item#> in
            <#code#>
        } titleForHeaderInSection: { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#>, <#Int#> in
            <#code#>
        } titleForFooterInSection: { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#>, <#Int#> in
            <#code#>
        } canEditRowAtIndexPath: { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#>, <#IndexPath#> in
            <#code#>
        } canMoveRowAtIndexPath: { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#>, <#IndexPath#> in
            <#code#>
        } sectionIndexTitles: { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#> in
            <#code#>
        } sectionForSectionIndexTitle: { <#TableViewSectionedDataSource<SearchViewModel.SectionModel>#>, <#String#>, <#Int#> in
            <#code#>
        }

    }
}
