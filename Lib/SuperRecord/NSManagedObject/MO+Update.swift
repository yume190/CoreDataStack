//
//  MO+Update.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData
//public extension NSManagedObject {
//
//    //MARK: Entity update
//
//    /**
//    Update all entity matching the predicate
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//    - parameter propertiesToUpdate:
//    - parameter predicate: the predicate the entity should match
//    - parameter resultType: the default value is UpdatedObjectsCountResultType (rows number)
//    - parameter error:
//
//    - returns: AnyObject? depends on resultType
//    */
//
//    static func updateAll (context: NSManagedObjectContext = mainMOC!, propertiesToUpdate: [String : AnyObject], predicate:NSPredicate?, resultType: NSBatchUpdateRequestResultType = .UpdatedObjectsCountResultType) throws -> AnyObject{
//        let error: Error = NSError(domain: "Migrator", code: 0, userInfo: nil)
//        let entityName = String(self)
//        let request = NSBatchUpdateRequest(entityName: entityName)
//        request.propertiesToUpdate = propertiesToUpdate
//        request.resultType = resultType
//        request.predicate = predicate
//        let result =  try! context.executeRequest(request) as! NSBatchUpdateResult
//        if let value = result.result {
//            return value
//        }
//        throw error
//    }
//}

