//
//  MO+Fecth.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/29.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import CoreData

extension MOProtocol where Self: NSManagedObject {
    public typealias FetchRequestSetting = (NSFetchRequest<Self>) -> ()

    internal static func fetch<T>(context: NSManagedObjectContext, fetchRequest: NSFetchRequest<T>) -> [T] {
        var results:[T] = []
        
        context.performAndWait { () -> Void in
            do {
                results = try context.fetch(fetchRequest)
            } catch {
                print(error)
            }
        }
        
        return results
    }

    internal static func fetchRequest(predicate:NSPredicate?, context: NSManagedObjectContext, customSetting:FetchRequestSetting? = nil) -> NSFetchRequest<Self> {
        let fetchRequest = NSFetchRequest<Self>(entityName: self.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context)
        customSetting?(fetchRequest)
        return fetchRequest
    }
}
