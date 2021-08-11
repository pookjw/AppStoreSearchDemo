//
//  SearchViewModel.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    let requestSearch: PublishRelay<String> = .init()
}
