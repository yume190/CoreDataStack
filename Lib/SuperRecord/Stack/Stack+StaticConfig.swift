//
//  Stack+Config.swift
//  CoreData
//
//  Created by Yume on 2018/2/23.
//  Copyright © 2018年 Yume. All rights reserved.
//

import CoreData
import Foundation

internal struct SuperCoreDataStackConfig {
    internal static let bigUpdatePrefix = "_"
    internal static let defaultStackName:String = {
        let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String
        return bundleName ?? "YumeKit"
    }()
    internal static let stackOption = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true
    ]
}
