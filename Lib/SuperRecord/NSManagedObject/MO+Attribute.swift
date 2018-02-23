//
//  MO+Attribute.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

// MARK: extension attribute
extension MOProtocol where Self:NSManagedObject {
    public static var entityName: String {
        return String(describing: self)
    }
}
