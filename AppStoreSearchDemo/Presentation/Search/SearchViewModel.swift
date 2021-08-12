//
//  SearchViewModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import AppStoreSearchDemoCore

final class SearchViewModel {
    typealias SectionModel = RxDataSources.AnimatableSectionModel<SearchSectionModel, SearchItemModel>
    typealias DataSource = RxTableViewSectionedReloadDataSource<SectionModel>
    
    let requestRecentSearch: PublishRelay<String> = .init()
    let requestSoftwareSearch: PublishRelay<String> = .init()
    
    let dataSource: DataSource
    private(set) var dataSourceDriver: Driver<[SectionModel]>!
    
    private let queue: OperationQueue = {
        let queue: OperationQueue = .init()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    private let getSoftwareInfoUseCase: GetSoftwareInfosUseCase = GetSoftwareInfosUseCaseImpl()
    private let createRecentKeywordUseCase: CreateRecentKeywordUseCase = CreateRecentKeywordUseCaseImpl()
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
        
        let recentObservable: Observable<[String]> = requestRecentSearch
            .withLatestFrom(observeRecentKeywordUseCase.observe(), resultSelector: { (text, recents) in
                return (text, recents)
            })
            .subscribe(on: MainScheduler.instance) // Registering Realm's NSNotificationCenter requires Main Thread
            .observe(on: OperationQueueScheduler(operationQueue: queue))
            .map { (filter, recents) -> [String] in
                recents.filter { $0.contains(filter) }
            }
            .startWith([])
            .share()
        
        let searchObservable: Observable<[SoftwareInfo]> = requestSoftwareSearch
            .subscribe(on: OperationQueueScheduler(operationQueue: queue))
            .observe(on: OperationQueueScheduler(operationQueue: queue))
            .withUnretained(self)
            .do(onNext: { (weakSelf, text) in
                weakSelf
                    .createRecentKeywordUseCase
                    .create(text: text)
                    .subscribe()
                    .disposed(by: weakSelf.disposeBag)
            })
            .flatMap { (weakSelf, text) in
                weakSelf
                    .getSoftwareInfoUseCase
                    .get(text: text)
            }
            .startWith([])
            .share()
            .asObservable()
        
        //
        
         recentObservable
            .map { recents -> [SectionModel] in
                let items: [SearchItemModel] = recents
                    .map { .recent($0) }
                return [.init(model: .recents, items: items)]
            }
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        searchObservable
            .map { results -> [SectionModel] in
                let items: [SearchItemModel] = results
                    .map { .result($0) }
                return [.init(model: .results, items: items)]
            }
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
    }
}
