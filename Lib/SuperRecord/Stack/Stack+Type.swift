//
//  Stack+Type.swift
//  CoreDataStack
//
//  Created by Yume on 2018/2/23.
//  Copyright © 2018年 Yume. All rights reserved.
//

import Foundation
import CoreData

extension SuperCoreDataStack {
    public enum CoreDataType {
        case sql
        case memory
        case binary
        
        public var type: String {
            switch self {
            case .sql:
                return NSSQLiteStoreType
            case .memory:
                return NSInMemoryStoreType
            case .binary:
                return NSBinaryStoreType
            }
        }
        
        public var stack:SuperCoreDataStack? {
            return customStackName(name: SuperCoreDataStackConfig.defaultStackName, prefix: "")
        }
        
        public func customStackName(name:String,prefix:String) -> SuperCoreDataStack? {
            return SuperCoreDataStack(config: SuperCoreDataStack.Config(
                type: self,
                stackName: name,
                prefixName: prefix
            ))
//            return SuperCoreDataStack(
//                type:self,
//                stackName:name,
//                prefixName:prefix
//            )
        }
    }
}
