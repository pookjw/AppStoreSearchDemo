//
//  Network.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import Moya
import RxSwift

enum NetworkError: Error, LocalizedError {
    case invalidStatusCode(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidStatusCode(let code):
            return "request error (번역) \(code)"
        }
    }
}

protocol Network {
    func request<T: TargetType>(_ serviceType: T) -> Single<Data>
}
