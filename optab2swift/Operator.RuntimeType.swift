//
//  Operator.RuntimeType.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension Operator {
    enum RuntimeType: String {
        case Void = "Void"
        case NSExpression = "NSExpression"
        case NSComparisonPredicate = "NSComparisonPredicate"
        
        init(typeString: String) {
            switch typeString {
            case "Void":
                self = .Void
            case "NSExpression":
                self = .NSExpression
            case "NSComparisonPredicate":
                self = .NSComparisonPredicate
            default:
                debugPrintln("Unknown type string \(typeString)")
                abort()
            }
        }
    }
}