//
//  CompoundOperators.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

@infix public func && (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
    return NSCompoundPredicate.andPredicateWithSubpredicates([lhs, rhs])
}

@infix public func || (lhs: NSPredicate, rhs: NSPredicate) -> NSCompoundPredicate {
    return NSCompoundPredicate.orPredicateWithSubpredicates([lhs, rhs])
}

@prefix public func ! (rhs: NSPredicate) -> NSCompoundPredicate {
    return NSCompoundPredicate.notPredicateWithSubpredicate(rhs)
}
