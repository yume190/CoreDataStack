//
//  NSPredicate+LogicOperater.swift
//  SuperRecord
//
//  Created by Yume on 2018/1/15.
//  Copyright © 2018年 Michael Armstrong. All rights reserved.
//

import Foundation

public extension NSPredicate {
    /**
     Used to specify the the logical operator to use in the init of a complex NSPredicate
     */
    public enum NSLogicOperator: String {
        /**
         And Operator
         */
        case And = "AND"
        
        /**
         OR Operator
         */
        case Or = "OR"
    }
    
    /**
     Init a new NSPredicate using the input predicates adding parenthesis for more complex NSPredicate
     
     - parameter firstPredicate:
     - parameter secondPredicate:
     - parameter NSLogicOperator: to use in the predicate AND/OR
     
     - returns: NSPredicate
     */
    public convenience init(firstPredicate : NSPredicate, secondPredicate: NSPredicate, predicateOperator: NSLogicOperator ) {
        self.init(format: "(\(firstPredicate)) \(predicateOperator.rawValue) (\(secondPredicate))")
    }
}
