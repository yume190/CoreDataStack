//
//  MO+Create.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

extension MOProtocol where Self: NSManagedObject {
    public static func createNewEntity(_ context: NSManagedObjectContext = mainMOC!) -> Self {
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let obj = Self(entity: entityDescription!, insertInto: context)
        return obj
    }
}


//    /**
//    Search for the entity with the specify value or create a new Entity
//
//    :predicate: attribute predicate
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - returns: NSManagedObject.
//    */
//
//    static func findFirstOrCreateWithPredicate(predicate: NSPredicate!, context: NSManagedObjectContext = mainMOC!, handler: ((Error) -> Void)? = nil) -> NSManagedObject {
//        let entityName = String(self)
//        let entityDescription = NSEntityDescription.entityForName(entityName as String, inManagedObjectContext: context)
//        let fetchRequest = NSFetchRequest(entityName: entityName as String)
//        fetchRequest.fetchLimit = 1
//        fetchRequest.predicate = predicate
//        fetchRequest.entity = entityDescription
//        var fetchedObjects = NSArray()
//        let error : NSError? = nil
//        context.performBlockAndWait({ () -> Void in
//            let results = (try! context.executeFetchRequest(fetchRequest)) as NSArray
//            fetchedObjects = results
//        })
//        if let firstObject = fetchedObjects.firstObject as? NSManagedObject {
//            handler?(error)
//            return firstObject
//        }
//
//        let obj = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: context) as NSManagedObject
//
//        handler?(error)
//        return obj
//    }
//
//    /**
//    Create a new Entity
//
//    - parameter context: NSManagedObjectContext
//
//    - returns: NSManagedObject.
//    */
//    static func createNewEntity(context: NSManagedObjectContext = mainMOC!) -> NSManagedObject {
//        let entityName = String(self)
//        let entityDescription = NSEntityDescription.entityForName(entityName as String, inManagedObjectContext: context)
//        let obj = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: context)
//        return obj as NSManagedObject
//    }

//    /**
//    Search for the entity with the specify value or create a new Entity
//
//    - parameter attribute: name of the attribute to find
//
//    - parameter value: of the attribute to find
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - returns: NSManagedObject.
//    */
//    static func findFirstOrCreateWithAttribute(attribute: String!, value: AnyObject!, context: NSManagedObjectContext = mainMOC!, handler: ((Error) -> Void)? = nil) -> NSManagedObject {
//        let predicate = NSPredicate.predicateBuilder(attribute, value: value, predicateOperator: .Equal)
//        return findFirstOrCreateWithPredicate(predicate, context: context, handler: handler)
//    }
