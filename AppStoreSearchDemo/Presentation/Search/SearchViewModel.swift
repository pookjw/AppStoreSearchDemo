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
    
    let requestSearch: PublishRelay<String> = .init()
    
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
    
    deinit {
        queue.cancelAllOperations()
    }
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
}
