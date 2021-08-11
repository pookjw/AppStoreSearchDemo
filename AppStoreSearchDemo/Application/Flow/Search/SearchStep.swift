//
//  SearchStep.swift
//  AppStoreSearchDemo
//
//  Created by Jinwoo Kim on 8/11/21.
//

import Foundation
import RxFlow
import AppStoreSearchDemoCore

enum SearchStep: Step {
    case pushToDetails(SoftwareInfo)
}
