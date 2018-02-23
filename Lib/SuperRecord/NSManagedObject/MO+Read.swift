//
//  MO+Find.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

// MARK: Find All
extension MOProtocol where Self:NSManagedObject {
    public static func findAll(
        predicate: NSPredicate?,
        includesPropertyValues: Bool = true,
        context: NSManagedObjectContext = mainMOC!,
        fetchRequestConfig:((NSFetchRequest<Self>) -> ())? = nil) -> [Self] {
        
        let fetchRequest = Self.fetchRequest(predicate: predicate, context: context) { fetchRequest in
            fetchRequest.includesPropertyValues = includesPropertyValues
            fetchRequestConfig?(fetchRequest)
        }
        
        return fetch(context: context, fetchRequest: fetchRequest)
    }
    
    public static func findAll(context: NSManagedObjectContext = mainMOC!) -> [Self] {
        return findAll(predicate: nil, context: context)
    }
    
    public static func findAll(attribute: String!, value: Any, context: NSManagedObjectContext) -> [Self] {
        let predicate = NSPredicate.builder(attribute: attribute, value: value, predicateOperator: .Equal)
        return findAll(predicate: predicate, context: context)
    }
}

// MARK: Find First
extension MOProtocol where Self:NSManagedObject {
    public static func findFirst(predicate: NSPredicate!, context: NSManagedObjectContext = mainMOC!) -> Self? {
        let fetchRequest = Self.fetchRequest(predicate: predicate, context: context) { fetchRequest in
            fetchRequest.fetchLimit = 1
        }
        
        return fetch(context: context, fetchRequest: fetchRequest).first
    }
    
    public static func findFirstOrCreate(predicate: NSPredicate!, context: NSManagedObjectContext = mainMOC!) -> Self {
        if let first = findFirst(predicate: predicate, context: context) {
            return first
        }
        
        return createNewEntity(context)
    }
    
    public static func findFirstOrCreate(attribute: String!, value: Any!, context: NSManagedObjectContext = mainMOC!) -> Self {
        let predicate = NSPredicate.builder(attribute: attribute, value: value, predicateOperator: .Equal)
        return Self.findFirstOrCreate(predicate: predicate, context: context)
    }
}


//    /**
//    Search for all entity with the specify value or create a new Entity
//
//    - parameter predicate:
//
//    - parameter includesPropertyValues:
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - returns: NSArray of NSManagedObject.
//    */
//    static func findAllWithPredicate(predicate: NSPredicate!, includesPropertyValues: Bool = true, context: NSManagedObjectContext = mainMOC!, sortDescriptors: [NSSortDescriptor]? = nil, completionHandler handler: ((Error) -> Void)? = nil) -> NSArray {
//        let entityName = String(self)
//        let entityDescription = NSEntityDescription.entityForName(entityName as String, inManagedObjectContext: context)
//        let fetchRequest = NSFetchRequest(entityName: entityName as String)
//        fetchRequest.includesPropertyValues = includesPropertyValues
//        fetchRequest.predicate = predicate
//        fetchRequest.entity = entityDescription
//        fetchRequest.sortDescriptors = sortDescriptors
//        var results = NSArray()
//        let error : NSError? = nil
//        context.performBlockAndWait({ () -> Void in
//            results = (try! context.executeFetchRequest(fetchRequest)) as! [NSManagedObject]
//        })
//        handler?(error)
//        return results
//    }
//
//
//    /**
//    Search for all entity with the specify value or create a new Entity
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - returns: NSArray of NSManagedObject.
//    */
//    static func findAll(context: NSManagedObjectContext = mainMOC!, sortDescriptors: [NSSortDescriptor]? = nil) -> NSArray {
//        return findAllWithPredicate(nil, context: context, sortDescriptors:sortDescriptors)
//    }
//
//
//    /**
//    Search for all entity with the specify attribute and value
//
//    - parameter attribute: name of the attribute of the NSManagedObject
//
//    - parameter value: value of the attribute
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - returns: NSArray of NSManagedObject.
//    */
//    static func findAllWithAttribute(attribute: String!, value: AnyObject, context: NSManagedObjectContext = mainMOC!, sortDescriptors: [NSSortDescriptor]? = nil) -> NSArray {
//        let predicate = NSPredicate.predicateBuilder(attribute, value: value, predicateOperator: .Equal)
//        return findAllWithPredicate(predicate, context: context, sortDescriptors:sortDescriptors)
//    }
