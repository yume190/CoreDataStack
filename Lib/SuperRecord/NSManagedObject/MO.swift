//
//  MO.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

public protocol MOProtocol: class {}
extension NSManagedObject: MOProtocol {}
