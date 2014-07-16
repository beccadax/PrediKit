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
        
        init(typeString: String) {
            switch typeString {
            case "Void":
                self = .Void
            case "NSExpression":
                self = .NSExpression
            default:
                fatalError("Unknown RuntimeType type string")
            }
        }
    }
}