//
//  NetworkImpl.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import Moya
import RxSwift

final class NetworkImpl: Network {
    func request<T: TargetType>(_ serviceType: T) -> Single<Data> {
        return .create { promise in
            let provider: MoyaProvider<T> = .init()
            
            let cancellable: Cancellable = provider.request(serviceType) { result in
                switch result {
                case .failure(let error):
                    promise(.failure(error))
                case .success(let response):
                    let statusCode: Int = response.statusCode
                    guard statusCode ~= 200 else {
                        promise(.failure(NetworkError.invalidStatusCode(statusCode)))
                        return
                    }
                    promise(.success(response.data))
                }
            }
            
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
