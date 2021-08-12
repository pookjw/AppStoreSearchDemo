//
//  Observable+withOnlyUnretained.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/12/21.
//

import RxSwift

extension ObservableType {
    public func withOnlyUnretained<T>(_ obj: T) -> Observable<T> where T: AnyObject {
        withUnretained(obj)
            .map { (weakObj, _) in
                return weakObj
            }
    }
}
