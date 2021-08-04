//
//  Log.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import SwiftyBeaver

let log: SwiftyBeaver.Type = SwiftyBeaver.self

func initializeLog() {
    let console: BaseDestination = ConsoleDestination()
    log.addDestination(console)
}
