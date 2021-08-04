//
//  ItsDataStack.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import Moya
import RxSwift

enum ITSServiceType: Moya.TargetType {
    case software(String)
    
    // MARK: Moya.TargetType
    
    var baseURL: URL {
        var component: URLComponents = .init()
        component.scheme = "https"
        component.host = "itunes.apple.com"
        return component.url!
    }
    
    var path: String {
        "search"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        "{}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .software(let term):
            return .requestParameters(parameters: ["term": term, "entity": "software"],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? { nil }
}

final class ItsDataStack: NetworkImpl<ITSServiceType> {}
