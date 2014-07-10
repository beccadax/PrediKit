//
//  ExpressionOperators.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

// +

@infix func + (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "add:to:", arguments: [lhs, rhs])
}

@infix func + (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs + NSExpression(forConstantValue: rhs) }
@infix func + (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) + rhs }

// -

@infix func - (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "from:subtract:", arguments: [lhs, rhs])
}

@infix func - (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs - NSExpression(forConstantValue: rhs) }
@infix func - (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) - rhs }

// *

@infix func * (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "multiply:by:", arguments: [lhs, rhs])
}

@infix func * (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs * NSExpression(forConstantValue: rhs) }
@infix func * (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) * rhs }

// /

@infix func / (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "divide:by:", arguments: [lhs, rhs])
}

@infix func / (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs / NSExpression(forConstantValue: rhs) }
@infix func / (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) / rhs }

// %

@infix func % (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "modulus:by:", arguments: [lhs, rhs])
}

@infix func % (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs % NSExpression(forConstantValue: rhs) }
@infix func % (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) % rhs }

// unary -

@prefix func - (rhs: NSExpression) -> NSExpression {
    // Seriously, this is how they implement unary minus.
    // I couldn't believe it either.
    return 0 - rhs
}

// |

@infix func | (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "bitwiseOr:with:", arguments: [lhs, rhs])
}

@infix func | (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs | NSExpression(forConstantValue: rhs) }
@infix func | (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) | rhs }

// &

@infix func & (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "bitwiseAnd:with:", arguments: [lhs, rhs])
}

@infix func & (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs & NSExpression(forConstantValue: rhs) }
@infix func & (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) & rhs }

// ^

@infix func ^ (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "bitwiseXor:with:", arguments: [lhs, rhs])
}

@infix func ^ (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs ^ NSExpression(forConstantValue: rhs) }
@infix func ^ (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) ^ rhs }

// <<

@infix func << (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "leftshift:by:", arguments: [lhs, rhs])
}

@infix func << (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs << NSExpression(forConstantValue: rhs) }
@infix func << (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) << rhs }

// >>

@infix func >> (lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "rightshift:by:", arguments: [lhs, rhs])
}

@infix func >> (lhs: NSExpression, rhs: AnyObject) -> NSExpression { return lhs >> NSExpression(forConstantValue: rhs) }
@infix func >> (lhs: AnyObject, rhs: NSExpression) -> NSExpression { return NSExpression(forConstantValue: lhs) >> rhs }

// unary ~

@prefix func ~ (rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "onesComplement:", arguments: [rhs])
}

// pow()

func pow(lhs: NSExpression, rhs: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "raise:toPower:", arguments: [lhs, rhs])
}

func pow(lhs: NSExpression, rhs: AnyObject) -> NSExpression { return pow(lhs, NSExpression(forConstantValue: rhs)) }
func pow(lhs: AnyObject, rhs: NSExpression) -> NSExpression { return pow(NSExpression(forConstantValue: lhs), rhs) }

// Some other functions...

func countElements(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "count:", arguments: [ expr ])
}

func minElement(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "min:", arguments: [ expr ])
}

func maxElement(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "max:", arguments: [ expr ])
}

// XXX average:
// XXX median:
// XXX mode:
// XXX stddev:

func sqrt(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "sqrt:", arguments: [ expr ])
}

func log10(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "log:", arguments: [ expr ])
}

func log(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "ln:", arguments: [ expr ])
}

func exp(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "exp:", arguments: [ expr ])
}

func floor(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "floor:", arguments: [ expr ])
}

func ceil(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "ceiling:", arguments: [ expr ])
}

func abs(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "abs:", arguments: [ expr ])
}

func trunc(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "trunc:", arguments: [ expr ])
}

extension NSExpression {
    var uppercaseString: NSExpression {
        return NSExpression(forFunction: "uppercase:", arguments: [ self ])
    }
    var lowercaseString: NSExpression {
        return NSExpression(forFunction: "lowercase:", arguments: [ self ])
    }
}

func arc4random() -> NSExpression {
    return NSExpression(forFunction: "random", arguments: [ ])
}

func arc4random_uniform(expr: NSExpression) -> NSExpression {
    return NSExpression(forFunction: "random:", arguments: [ expr ])
}

func arc4random_uniform(limit: Int) -> NSExpression {
    return arc4random_uniform(NSExpression(forConstantValue: limit))
}

extension NSDate {
    class func dynamicDate() -> NSExpression {
        return NSExpression(forFunction: "now", arguments: [ ])
    }
}

// XXX noindex:

extension NSExpression {
    func distanceFromLocation(locationExpr: NSExpression) -> NSExpression {
        return NSExpression(forFunction: "distanceToLocation:fromLocation:", arguments: [self, locationExpr])
    }
}
