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
import RxDataSources

final class RecentsViewController: UIViewController, Steppable {
    var stepper: Stepper?
    private(set) var viewModel: RecentsViewModel!
    private var disposeBag: DisposeBag = .init()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        configureTableView()
        configureViewModel()
        bind()
    }
    

    private func setAttributes() {
        title = "검색 (번역)"
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self)
    }
    
    private func configureViewModel() {
        let viewModel: RecentsViewModel = .init(dataSource: makeDataSource())
        self.viewModel = viewModel
    }
    
    private func bind() {
        viewModel
            .dataSourceDriver
            .drive(tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeDataSource() -> RecentsViewModel.DataSource {
        let dataSource: RecentsViewModel.DataSource = .init { ds, tv, indexPath, item in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
            
            let text: String
            
            switch item {
            case .recent(let _text):
                text = _text
            }
            
            // on iOS 14.0 or later, accessing directly to textLabel of default cell style is deprecated.
            if #available(iOS 14.0, *) {
                var configuration: UIListContentConfiguration = cell.defaultContentConfiguration()
                configuration.text = text
                cell.contentConfiguration = configuration
            } else {
                cell.textLabel?.text = text
            }
            
            return cell
        } titleForHeaderInSection: { sectionModel, row in
            return "최근 검색어 (번역)"
        }
        
        return dataSource
    }
}

extension RecentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let item: RecentsViewModel.SectionModel.Item = viewModel.dataSource[indexPath]
        
        switch item {
        case .recent(let text):
            stepper?.steps.accept(SearchStep.requestSearch(text))
        }
    }
}
