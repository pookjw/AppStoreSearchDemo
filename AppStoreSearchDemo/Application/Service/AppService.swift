//
//  AppService.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxFlow

final class AppService {
    let searchService: SearchService = .init()
}

protocol AppServiceFlow: Flow {
    var appService: AppService { get }
}
