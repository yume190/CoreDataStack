//
//  MO+Aggregate.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

extension MOProtocol where Self: NSManagedObject {
    public func count(_ context: NSManagedObjectContext = mainMOC!, predicate : NSPredicate? = nil) throws -> Int {
        let fetchRequest = Self.fetchRequest(predicate: predicate, context: context) { fetchRequest in
            fetchRequest.includesPropertyValues = false
            fetchRequest.includesSubentities = false
            fetchRequest.propertiesToFetch = []
        }
        
        return try! context.count(for: fetchRequest)
    }
}

//    //MARK: Entity operations
//
//    /**
//    Count all the entity
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - parameter error:
//
//    - returns: Int of total result set count.
//    */
//    static func count(context: NSManagedObjectContext = mainMOC!, error: NSErrorPointer) -> Int {
//        return count(context, predicate: nil, error: error)
//    }
//
//    /**
//    Count all the entity matching the input predicate
//
//    - parameter context: the NSManagedObjectContext. Default value is mainMOC
//
//    - parameter predicate:
//
//    - parameter error:
//
//    - returns: Int of total result set count.
//    */
//    static func count(context: NSManagedObjectContext = mainMOC!, predicate : NSPredicate?, error: NSErrorPointer) -> Int {
//            let entityName = String(self)
//            let fetchRequest = NSFetchRequest(entityName: entityName as String)
//            fetchRequest.includesPropertyValues = false
//            fetchRequest.includesSubentities = false
//            fetchRequest.predicate = predicate
//            fetchRequest.propertiesToFetch = []
//            return context.countForFetchRequest(fetchRequest, error: error)
//    }
//}

extension MOProtocol where Self: NSManagedObject {
    static func function(
        context: NSManagedObjectContext = mainMOC!,
        function: String,
        fieldName: [String],
        predicate : NSPredicate?,
        groupByFieldName: [String]) -> [AnyObject] {
        
        
        var expressionsDescription:[Any] = []
        for field in fieldName{
            let expression = NSExpression(forKeyPath: field)
            let expressionDescription = NSExpressionDescription()
            expressionDescription.expression = NSExpression(forFunction: function, arguments: [expression])
            expressionDescription.expressionResultType = NSAttributeType.doubleAttributeType
            expressionDescription.name = field
            expressionsDescription.append(expressionDescription)
        }
        
        let entityName = String(describing: self)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName as String)
        
        if(groupByFieldName.count > 0 ){
            fetchRequest.propertiesToGroupBy = groupByFieldName
            for groupBy in groupByFieldName {
                expressionsDescription.append(groupBy)
            }
            
        }
        
        fetchRequest.propertiesToFetch = expressionsDescription
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        fetchRequest.predicate = predicate
        
        var results = [AnyObject]()
        
        context.performAndWait {
            do {
                try results = context.fetch(fetchRequest) as [AnyObject]!
            } catch {
                
            }
            
        }
        return results
    }
    
    static func function(
        context: NSManagedObjectContext = mainMOC!,
        function: String,
        fieldName: [String],
        predicate : NSPredicate?) -> [Double] {
        
        let results = self.function(context: context, function: function , fieldName: fieldName, predicate: predicate, groupByFieldName: [])
        var resultValue = [Double]()
        
        var tempResult = [Double]()
        for result in results{
            for field in fieldName{
                let value = result.value(forKey:field) as! Double
                tempResult.append(value)
            }
        }
        resultValue = tempResult
        return resultValue
    }
}

extension MOProtocol where Self:NSManagedObject {
    
//    static func sum(context: NSManagedObjectContext = mainMOC!, fieldName: String, predicate : NSPredicate? = nil, handler: ((Error) -> Void)? = nil) -> Double! {
//        var results = sum(context, fieldName: [fieldName], predicate: predicate, handler: handler)
//        return results.isEmpty ? 0 : results[0]
//    }
//
    static func sum(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate? = nil) -> [Double] {
        return function(context: context, function: "sum:", fieldName: fieldName, predicate: predicate)
    }
//    static func sum(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, groupByField:[String])-> [AnyObject] {
//        return function(context, function: "sum:", fieldName: fieldName, predicate: predicate, groupByFieldName: groupByField, handler: handler)
//    }
}




//
//    static func max(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, handler: ((Error) -> Void)) -> [Double] {
//        return function(context, function: "max:", fieldName: fieldName, predicate: predicate, handler: handler)
//    }
//
//    static func max(context: NSManagedObjectContext = mainMOC!, fieldName: String, predicate : NSPredicate? = nil, handler: ((Error) -> Void)? = nil) -> Double! {
//        var results = max(context, fieldName: [fieldName], predicate: predicate, handler: handler)
//        return results.isEmpty ? 0 : results[0]
//    }
//
//    static func max(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, groupByField:[String], handler: ((Error) -> Void))-> [AnyObject] {
//        return function(context, function: "max:", fieldName: fieldName, predicate: predicate, groupByFieldName: groupByField, handler: handler)
//    }
//
//    static func min(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, handler: ((Error) -> Void)) -> [Double] {
//        return function(context, function: "min:", fieldName: fieldName, predicate: predicate, handler: handler)
//    }
//
//    static func min(context: NSManagedObjectContext = mainMOC!, fieldName: String, predicate : NSPredicate? = nil, handler: ((Error) -> Void)? = nil) -> Double! {
//        var results = min(context, fieldName: [fieldName], predicate: predicate, handler: handler)
//        return results.isEmpty ? 0 : results[0]
//    }
//
//    static func min(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, groupByField:[String], handler: ((Error) -> Void))-> [AnyObject] {
//        return function(context, function: "min:", fieldName: fieldName, predicate: predicate, groupByFieldName: groupByField, handler: handler)
//    }
//
//    static func avg(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, handler: ((Error) -> Void)) -> [Double] {
//        return function(context, function: "average:", fieldName: fieldName, predicate: predicate, handler: handler)
//    }
//
//    static func avg(context: NSManagedObjectContext = mainMOC!, fieldName: String, predicate : NSPredicate? = nil, handler: ((Error) -> Void)?  = nil) -> Double! {
//        var results = avg(context, fieldName: [fieldName], predicate: predicate, handler: handler)
//        return results.isEmpty ? 0 : results[0]
//    }
//
//    static func avg(context: NSManagedObjectContext = mainMOC!, fieldName: [String], predicate : NSPredicate?, groupByField:[String], handler: ((Error) -> Void))-> [AnyObject] {
//        return function(context, function: "average:", fieldName: fieldName, predicate: predicate, groupByFieldName: groupByField, handler: handler)
//    }
