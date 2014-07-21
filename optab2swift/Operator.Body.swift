//
//  Operator.Body.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension Operator {
    enum Body {
        case Function (functionName: String)
        case Comparison (typeName: String)
        case Custom (code: String)
        
        init(typeString: String, contentString: String) {
            switch typeString {
            case "function":
                self = .Function (functionName: contentString)
            case "comparison":
                self = .Comparison (typeName: contentString)
            case "custom":
                self = .Custom (code: contentString)
            default:
                debugPrintln("Unknown operator body type \(typeString)")
                abort()
            }
        }
        
        func generateCode(#operands: [String], anyObjectOperands: [Int]) -> String {
            let enumeratedOperands = realEnumerate(operands)
            let literalOperands = Array(enumeratedOperands).map { (i, name) -> String in
                if contains(anyObjectOperands, i) {
                    return "NSExpression(forConstantValue: \(name))"
                }
                else {
                    return name
                }
            }
            
            switch self {
            case let .Function(functionName: name):
                let operandList = join(", ", literalOperands)
                return "NSExpression(forFunction: \"\(name)\", arguments: [\(operandList)])"
            case let .Comparison(typeName: name):
                return "NSComparisonPredicate(leftExpression: \(literalOperands[0]), rightExpression: \(literalOperands[1]), modifier: .DirectPredicateModifier, type: .\(name), options: nil)"
            case let .Custom(code: code):
                return code
            }
        }
    }
}