//
//  ITSServiceType.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/5/21.
//

import Foundation
import Moya

enum ITSServiceType: Moya.TargetType {
    case software(String)
    case lookup(String)
    
    // MARK: Moya.TargetType
    
    var baseURL: URL {
        var component: URLComponents = .init()
        component.scheme = "https"
        component.host = "itunes.apple.com"
        return component.url!
    }
    
    var path: String {
        switch self {
        case .software(_):
            return "search"
        case .lookup(_):
            return "lookup"
        }
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
        case .lookup(let id):
            return .requestParameters(parameters: ["id": id],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
