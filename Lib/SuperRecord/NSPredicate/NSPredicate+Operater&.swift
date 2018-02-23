//
//  NSPredicate+Operater&.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/15.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import Foundation

//MARK: Logical operators &
extension NSPredicate {
    /**
     Create a new NSPredicate as logical AND of left and right predicate
     
     - parameter left:
     - parameter right:
     
     - returns: NSPredicate
     */
    public static func & (left : NSPredicate, right : NSPredicate) -> NSPredicate {
        return [left] & [right]
    }
    
    /**
     Create a new NSPredicate as logical AND of left and right predicates
     
     - parameter left:
     - parameter right: a collection NSPredicate
     
     - returns: NSPredicate
     */
    public static func & (left : NSPredicate, right : [NSPredicate] ) -> NSPredicate {
        return [left] & right
    }
}

extension Array where Element == NSPredicate {
    /**
     Create a new NSPredicate as logical AND of left and right predicates
     
     - parameter left: a collection NSPredicate
     - parameter right: a collection NSPredicate
     
     - returns: NSPredicate
     */
    public static func & (left : [NSPredicate], right : [NSPredicate]) -> NSPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: left + right)
    }
}
