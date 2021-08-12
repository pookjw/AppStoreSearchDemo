//
//  DetailsViewController.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow

final class DetailsViewController: UIViewController, Steppable {
    var stepper: Stepper?
    private(set) var viewModel: DetailsViewModel!
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
        let viewModel: DetailsViewModel = .init(dataSource: makeDataSource())
        self.viewModel = viewModel
    }
    
    private func bind() {
        viewModel
            .dataSourceDriver
            .drive(tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
    
    private func makeDataSource() -> DetailsViewModel.DataSource {
        let animationConfiguration: AnimationConfiguration = .init(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
        
        let dataSource: DetailsViewModel.DataSource = .init(animationConfiguration: animationConfiguration) { ds, tv, indexPath, item in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
            
            switch item {
            case .intro(let info):
                if #available(iOS 14.0, *) {
                    let configuration: DetailsIntroConfiguration = .init(softwareInfo: info)
                    cell.contentConfiguration = configuration
                } else {
                    cell.removeAllSubviews()
                    let contentView: DetailsIntroContentView = .loadFromNib()
                    contentView.softwareInfo = info
                    cell.addSubview(contentView)
                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    contentView.snp.remakeConstraints { $0.edges.equalToSuperview() }
                }
            case .previews(let info):
                if #available(iOS 14.0, *) {
                    let configuration: DetailsPreviewsConfiguration = .init(softwareInfo: info)
                    cell.contentConfiguration = configuration
                } else {
                    cell.removeAllSubviews()
                    let contentView: DetailsPreviewsContentView = .loadFromNib()
                    contentView.softwareInfo = info
                    cell.addSubview(contentView)
                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    contentView.snp.remakeConstraints { $0.edges.equalToSuperview() }
                }
            }
            
            return cell
        }
        
        return dataSource
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item: DetailsViewModel.SectionModel.Item = viewModel.dataSource[indexPath]
        return item.height
    }
}
