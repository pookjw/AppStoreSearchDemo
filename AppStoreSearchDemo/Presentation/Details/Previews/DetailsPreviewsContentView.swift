//
//  DetailsPreviewsContentView.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import AppStoreSearchDemoCore

final class DetailsPreviewsContentView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var _configuration: Any?
    
    var softwareInfo: SoftwareInfo? {
        didSet {
            if let softwareInfo: SoftwareInfo = softwareInfo {
                updateInfo(softwareInfo)
            }
        }
    }
    
    private var viewModel: DetailsPreviewsContentViewModel!
    private var disposeBag: DisposeBag = .init()
    
    private func updateInfo(_ softwareInfo: SoftwareInfo) {
        viewModel.requestDataSource.accept(softwareInfo)
    }
    
    //
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        configureViewModel()
        bind()
    }
    
    private func configureViewModel() {
        let viewModel: DetailsPreviewsContentViewModel = .init(dataSource: makeDataSource())
        self.viewModel = viewModel
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self)
    }
    
    private func makeDataSource() -> DetailsPreviewsContentViewModel.DataSource {
        let dataSource: DetailsPreviewsContentViewModel.DataSource = .init { ds, cv, indexPath, item in
            let cell: UICollectionViewCell = cv.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier, for: indexPath)
            
            switch item {
            case .image(let url):
                if #available(iOS 14.0, *) {
                    let configuration: DetailsPreviewConfiguration = .init(imageURL: url)
                    cell.contentConfiguration = configuration
                } else {
                    cell.removeAllSubviews()
                    let contentView: DetailsPreviewContentView = .loadFromNib()
                    contentView.imageURL = url
                    cell.addSubview(contentView)
                    contentView.translatesAutoresizingMaskIntoConstraints = false
                    contentView.snp.remakeConstraints { $0.edges.equalToSuperview() }
                }
            }
            
            return cell
        }
        
        return dataSource
    }
    
    private func bind() {
        viewModel
            .dataSourceDriver
            .drive(collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
}

@available(iOS 14.0, *)
extension DetailsPreviewsContentView: UIContentView {
    var configuration: UIContentConfiguration {
        get {
            return _configuration as! UIContentConfiguration
        }
        set(newValue) {
            _configuration = newValue
            
            if let introConfiguration: DetailsPreviewsConfiguration = newValue as? DetailsPreviewsConfiguration {
                softwareInfo = introConfiguration.softwareInfo
            }
        }
    }
}

extension DetailsPreviewsContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
