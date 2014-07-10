//
//  SetOperators.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

// These are a little unsatisfying, since they're not normal Swift usages.
// But we can't overload operators like + and - to mean one thing for a 
// set NSExpression and another thing for a numeric NSExpression since
// NSExpressions are untyped, and we can't put an extension on 
// NSExpression imitating existing methods on NSSet since some of these 
// operations can only be done with an NSMutableSet.
// 
// FML.

operator infix ∪ {}
@infix func ∪ (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forUnionSet: lhs, with: rhs)
}

operator infix ∩ {}
@infix func ∩ (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forIntersectSet: lhs, with: rhs)
}

operator infix ∖ {}
@infix func ∖ (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forMinusSet: lhs, with: rhs)
}
