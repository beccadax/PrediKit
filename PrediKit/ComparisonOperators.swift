//
//  ComparisonOperators.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

// contains()

public func contains(list: NSExpression, item: NSExpression) -> NSComparisonPredicate {
    return NSComparisonPredicate(leftExpression: list, rightExpression: item, modifier: .DirectPredicateModifier, type: .ContainsPredicateOperatorType, options: nil)
}

public func contains(list: [AnyObject], item: NSExpression) -> NSComparisonPredicate { return contains(NSExpression(forConstantValue: list), item) }
public func contains(list: NSSet, item: NSExpression) -> NSComparisonPredicate { return contains(NSExpression(forConstantValue: list), item) }
public func contains(list: NSExpression, item: AnyObject) -> NSComparisonPredicate { return contains(list, NSExpression(forConstantValue: item)) }

// range ~= value (between)
// 
// We can't use real Ranges because we want to be able to mix NSExpressions and constant values, so we override ..< and ... to return an NSExpression-NSExpression tuple when a range is involved, and define a ~= that operates on those tuples.

public struct ExpressionRange {
    let startIndex: NSExpression
    let endIndex: NSExpression
    
    var expression: NSExpression {
        return NSExpression(forAggregate: [ startIndex, endIndex ])
    }
    
    init(startIndex: NSExpression, endIndex: NSExpression, inclusive: Bool) {
        self.startIndex = startIndex
        self.endIndex = inclusive ? endIndex : (endIndex - 1)
    }
    
    init(startIndex: NSExpression, endIndex: AnyObject, inclusive: Bool) {
        self.init(startIndex: startIndex, endIndex: NSExpression(forConstantValue: endIndex), inclusive: inclusive)
    }

    init(startIndex: AnyObject, endIndex: NSExpression, inclusive: Bool) {
        self.init(startIndex: NSExpression(forConstantValue: startIndex), endIndex: endIndex, inclusive: inclusive)
    }

    init(startIndex: AnyObject, endIndex: AnyObject, inclusive: Bool) {
        self.init(startIndex: startIndex, endIndex: NSExpression(forConstantValue: endIndex), inclusive: inclusive)
    }
    
    init(range: Range<Int>) {
        self.init(startIndex: range.startIndex, endIndex: range.endIndex, inclusive: false)
    }
    
/*    init(range: Range<Double>) {
        self.init(startIndex: range.startIndex, endIndex: range.endIndex, inclusive: false)
    }*/
}

@infix public func ~= (lhs: ExpressionRange, rhs: NSExpression) -> NSComparisonPredicate {
    return NSComparisonPredicate(leftExpression: rhs, rightExpression: lhs.expression, modifier: .DirectPredicateModifier, type: .BetweenPredicateOperatorType, options: nil)
}

@infix public func ~= (var lhs: Range<Int>, rhs: NSExpression) -> NSComparisonPredicate {
    return ExpressionRange(range: lhs) ~= rhs
}
/*@infix func ~= (lhs: Range<Double>, rhs: NSExpression) -> NSComparisonPredicate {
    return ExpressionRange(range: lhs) ~= rhs
}*/

// These create our fake NSExpression ranges
// ..<
@infix public func ..< (lhs: NSExpression, rhs: NSExpression) -> ExpressionRange {
    return ExpressionRange(startIndex: lhs, endIndex: rhs, inclusive: false)
}

@infix public func ..< (lhs: NSExpression, rhs: AnyObject) -> ExpressionRange {
    return ExpressionRange(startIndex: lhs, endIndex: rhs, inclusive: false)
}

@infix public func ..< (lhs: AnyObject, rhs: NSExpression) -> ExpressionRange {
    return ExpressionRange(startIndex: lhs, endIndex: rhs, inclusive: false)
}

// ...
@infix public func ... (lhs: NSExpression, rhs: NSExpression) -> ExpressionRange {
    return ExpressionRange(startIndex: lhs, endIndex: rhs, inclusive: true)
}

@infix public func ... (lhs: NSExpression, rhs: AnyObject) -> ExpressionRange {
    return ExpressionRange(startIndex: lhs, endIndex: rhs, inclusive: true)
}

@infix public func ... (lhs: AnyObject, rhs: NSExpression) -> ExpressionRange {
    return ExpressionRange(startIndex: lhs, endIndex: rhs, inclusive: true)
}

// Any/all/none modifiers

public func any(pred: NSComparisonPredicate) -> NSComparisonPredicate {
    return NSComparisonPredicate(leftExpression: pred.leftExpression, rightExpression: pred.rightExpression, modifier: .AnyPredicateModifier, type: pred.predicateOperatorType, options: pred.options)
}

public func all(pred: NSComparisonPredicate) -> NSComparisonPredicate {
    return NSComparisonPredicate(leftExpression: pred.leftExpression, rightExpression: pred.rightExpression, modifier: .AllPredicateModifier, type: pred.predicateOperatorType, options: pred.options)
}

public func none(pred: NSComparisonPredicate) -> NSCompoundPredicate {
    return !any(pred)
}
