//
//  MO+Delete.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

//
//
//    //MARK: Entity deletion
//
//    /**
//    Delete all entity
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    */
//    static func deleteAll(context: NSManagedObjectContext = mainMOC!) -> Void {
//        deleteAll(nil, context: context)
//    }
//
//    /**
//    Delete all entity matching the input predicate
//
//    - parameter predicate:
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    */
//    static func deleteAll(predicate: NSPredicate!, context: NSManagedObjectContext = mainMOC!) -> Void {
//        let results = findAllWithPredicate(predicate, includesPropertyValues: false, context: context, completionHandler: nil)
//        for result in results {
//            context.deleteObject(result as! NSManagedObject)
//        }
//    }
