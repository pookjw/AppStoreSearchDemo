//
//  RecentsViewModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import AppStoreSearchDemoCore

final class RecentsViewModel {
    typealias SectionModel = RxDataSources.AnimatableSectionModel<RecentsSectionModel, RecentsItemModel>
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<SectionModel>
    
    let dataSource: DataSource
    private(set) var dataSourceDriver: Driver<[SectionModel]>!
    
    private let queue: OperationQueue = {
        let queue: OperationQueue = .init()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    private let observeRecentKeywordUseCase: ObserveRecentKeywordUseCase = ObserveRecentKeywordUseCaseImpl()
    
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
        
        let recentObservable: Observable<[String]> = observeRecentKeywordUseCase
            .observe()
            .subscribe(on: MainScheduler.instance) // Registering Realm's Notification requires Main Thread
            .observe(on: OperationQueueScheduler(operationQueue: queue))
            .do(onError: { error in
                log.error(error.localizedDescription)
            })
            .startWith([])
            .share()
        
        //
        
        recentObservable
            .map { recents -> [SectionModel] in
                let items: [SectionModel.Item] = recents
                    .map { .recent($0) }
                return [.init(model: .recents, items: items)]
            }
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
    }
}
