//
//  DetailsViewModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxSwift
import RxCocoa
import AppStoreSearchDemoCore

final class DetailsViewModel {
    private(set) var requestDataSource: PublishRelay<SoftwareInfo> = .init()
}
