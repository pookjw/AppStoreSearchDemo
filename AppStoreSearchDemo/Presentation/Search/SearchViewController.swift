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
import SnapKit
import AppStoreSearchDemoCore

final class SearchViewController: UIViewController, Steppable {
    var stepper: Stepper?
    private(set) var viewModel: SearchViewModel!
    private var disposeBag: DisposeBag = .init()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()
        bind()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self)
    }
    
    private func configureViewModel() {
        let viewModel: SearchViewModel = .init(dataSource: makeDataSource())
        self.viewModel = viewModel
    }
    
    private func bind() {
        viewModel
            .dataSourceDriver
            .drive(tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeDataSource() -> SearchViewModel.DataSource {
        let dataSource: SearchViewModel.DataSource = .init { ds, tv, indexPath, item in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
            
            switch item {
            case .recent(let text):
                // on iOS 14.0 or later, accessing directly to textLabel of default cell style is deprecated.
                if #available(iOS 14.0, *) {
                    var configuration: UIListContentConfiguration = cell.defaultContentConfiguration()
                    configuration.text = text
                    cell.contentConfiguration = configuration
                } else {
                    cell.textLabel?.text = text
                }
            case .result(let info):
                if #available(iOS 14.0, *) {
                    let configuration: SearchSoftwareInfoConfiguration = .init(softwareInfo: info)
                    cell.contentConfiguration = configuration
                } else {
                    cell.removeAllSubviews()
                    let contentView: SearchSoftwareInfoContentView = .loadFromNib()
                    contentView.softwareInfo = info
                    cell.addSubview(contentView)
                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    contentView.snp.remakeConstraints { $0.edges.equalToSuperview() }
                }
            }
            
            return cell
        } titleForHeaderInSection: { section, row in
            let sectionModel: SearchViewModel.SectionModel = section.sectionModels[row]
            
            switch sectionModel.model {
            case .recents:
                return "최근 검색어 (번역)"
            case .results:
                return "결과 (번역)"
            }
        }

        return dataSource
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let item: SearchViewModel.SectionModel.Item = viewModel.dataSource[indexPath]
        
        switch item {
        case .recent(let text):
            stepper?.steps.accept(SearchStep.requestSearch(text))
        case .result(let info):
            stepper?.steps.accept(SearchStep.pushToDetails(info))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}
