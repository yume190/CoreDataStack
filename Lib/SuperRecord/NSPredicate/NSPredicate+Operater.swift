//
//  NSPredicateExtension.swift
//  SuperRecord
//
//  Created by Piergiuseppe Longo on 26/11/14.
//  Copyright (c) 2014 Michael Armstrong. All rights reserved.
//

import Foundation

public extension NSPredicate {
    
    /**
     Used to specify the the operator to use in NSPredicate.predicateBuilder
     */
    public enum NSPredicateOperator : String {
        /**
         Operator &&
         */
        case And = "AND"
        
        /**
         Operator ||
         */
        case Or = "OR"
        
        /**
         Operator IN
         */
        case In = "IN"
        
        /**
         Operator ==
         */
        case Equal = "=="
        
        /**
         Operator !=
         */
        case NotEqual = "!="
        
        /**
         Operator >
         */
        case GreaterThan = ">"
        
        /**
         Operator >=
         */
        case GreaterThanOrEqual = ">="
        
        /**
         Operator <
         */
        case LessThan = "<"
        
        /**
         Operator <=
         */
        case LessThanOrEqual = "<="
        
        /**
         Operator <=
         */
        case Contains = "contains[c]"
    }

    /**
    Build NSPredicate using the input parameters

    - parameter attribute: the name of the attribute
    - parameter value: the value the attribute should assume
    - parameter predicateOperator: to use in the predicate
    
    - returns: NSPredicate
    */
    public class func builder(attribute: String!, value: Any, predicateOperator: NSPredicateOperator) -> NSPredicate {
        var predicate = NSPredicate(format: "%K \(predicateOperator.rawValue) $value", attribute)
        predicate = predicate.withSubstitutionVariables(["value" : value])
        return predicate
    }
}
