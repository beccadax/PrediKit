//
//  Functions.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension NSPredicate {
    public class func fromClosure(closure: DynamicSelf -> NSPredicate) -> NSPredicate {
        return closure(DynamicSelf())
    }
    
    public class func fromClosureWithVariables(variables: [String], _ closure: (DynamicSelf, DynamicVariables) -> NSPredicate) -> NSPredicate {
        return closure(DynamicSelf(), DynamicVariables(supportedVariables: variables))
    }
}

extension NSExpression {
    public class func fromClosure(closure: DynamicSelf -> NSExpression) -> NSExpression {
        return closure(DynamicSelf())
    }
    
    public class func fromClosureWithVariables(variables: [String], _ closure: (DynamicSelf, DynamicVariables) -> NSExpression) -> NSExpression {
        return closure(DynamicSelf(), DynamicVariables(supportedVariables: variables))
    }
}

//let pred: NSPredicate = NSPredicate.fromClosure { dynamicSelf in dynamicSelf["age"] >= 18 && dynamicSelf["gender"] == "m" }
