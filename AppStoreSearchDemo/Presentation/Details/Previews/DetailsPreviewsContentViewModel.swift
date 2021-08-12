//
//  DetailsPreviewsContentViewModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/13/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import AppStoreSearchDemoCore

final class DetailsPreviewsContentViewModel {
    typealias SectionModel = RxDataSources.AnimatableSectionModel<DetailsPreviewsSectionModel, DetailsPreviewsItemModel>
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<SectionModel>
    
    let requestDataSource: PublishRelay<SoftwareInfo> = .init()
    
    private let queue: OperationQueue = {
        let queue: OperationQueue = .init()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    let dataSource: DataSource
    private(set) var dataSourceDriver: Driver<[SectionModel]>!
    private var disposeBag: DisposeBag = .init()
    
    deinit {
        queue.cancelAllOperations()
    }
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
        bind()
    }
    
    private func bind() {
        let dataSourceRelay: BehaviorRelay<[SectionModel]> = .init(value: [])
        self.dataSourceDriver = dataSourceRelay
            .asObservable()
            .asDriver(onErrorJustReturn: [])
        
        //
        
        requestDataSource
            .observe(on: OperationQueueScheduler(operationQueue: queue))
            .map { info -> [SectionModel] in
                let items: [SectionModel.Item] = info.screenshotUrls
                    .compactMap { $0 }
                    .map { .image($0) }
                return [.init(model: .noname, items: items)]
            }
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
    }
}
