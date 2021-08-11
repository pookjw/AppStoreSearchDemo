//
//  Log.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import SwiftyBeaver

public let log: SwiftyBeaver.Type = SwiftyBeaver.self

public func initializeLog() {
    let console: BaseDestination = ConsoleDestination()
    log.addDestination(console)
}
