//
//  DynamicSelf.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

public struct DynamicSelf {
    /// Subscript to examine a key path
    public subscript (keyPath: String?) -> NSExpression {
        if let realKeyPath = keyPath {
            return NSExpression(forKeyPath: realKeyPath)
        }
        else {
            return NSExpression.expressionForAnyKey()
        }
    }
    
    /// Use where an expression is required to examine self
    public func __conversion() -> NSExpression {
        return NSExpression.expressionForEvaluatedObject()
    }
}
