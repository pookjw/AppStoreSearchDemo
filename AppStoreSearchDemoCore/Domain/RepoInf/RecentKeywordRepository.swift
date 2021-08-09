//
//  RecentKeywordRepository.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import RealmSwift
import RxSwift

protocol RecentKeywordRepository {
    func getList() -> Single<[RecentKeyword]>
    
    func create(block: @escaping ((RecentKeyword) -> ())) -> Single<RecentKeyword>
    
    func observe() -> Observable<[RecentKeyword]>
}
