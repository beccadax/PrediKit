//
//  Operator.Declaration.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension Operator {
    enum Declaration {
        case InfixOperator (name: String)
        case PrefixOperator (name: String)
        case VoidFunction (name: String, extending: String?, onType: Bool)
        case UnaryFunction (name: String, extending: String?, onType: Bool)
        case BinaryFunction (name: String, extending: String?, onType: Bool)
        case ComputedProperty (name: String, extending: String?, onType: Bool)
        
        var operands: [ String ] {
            switch self {
            case .InfixOperator, .BinaryFunction:
                return [ "lhs", "rhs" ]
            case .PrefixOperator, .UnaryFunction: 
                return [ "expr" ]
            case .VoidFunction:
                return []
            case .ComputedProperty:
                return [ "self" ]
            }
        }
        
        func definitionInScope(#definition: String) -> String {
            if let extendingType = self.extending {
                var scope = "extension \(extendingType) {\n"
                
                for line in split(definition, { $0 == "\n" }) {
                    scope += "    \(line)\n"
                }
                
                scope += "}\n"
                
                return scope
            }
            else {
                return definition
            }
        }
        
        func swiftDeclaration(#argumentType: RuntimeType, anyObjectArguments: [Int], returnType: RuntimeType) -> String {
            var decl = ""
            
            switch self {
            case .UnaryFunction (name: _, extending: _, onType: true), 
                .BinaryFunction (name: _, extending: _, onType: true),
                .ComputedProperty (name: _, extending: _, onType: true):
                decl += "class "
            default:
                break
            }
            
            switch self {
            case .ComputedProperty:
                decl += "var \(name): "
            case .PrefixOperator:
                decl += "@prefix "
                fallthrough
            case .InfixOperator, .VoidFunction, .UnaryFunction, .BinaryFunction:
                decl += "func \(name) ("
                decl += join(", ", map(realEnumerate(operands)) { (i, name) in
                    if contains(anyObjectArguments, i) {
                        return "\(name): AnyObject"
                    }
                    else {
                        return "\(name): \(argumentType.toRaw())"
                    }
                })
                decl += ") -> "
            }
            
            decl += returnType.toRaw()
            
            return decl
        }
        
        var name: String {
            switch self {
            case let .ComputedProperty (name: name, extending: _, onType: _):
                return name
            case let .InfixOperator (name: name):
                return name
            case let .PrefixOperator (name: name):
                return name
            case let .VoidFunction (name: name, extending: _, onType: _):
                return name
            case let .UnaryFunction (name: name, extending: _, onType: _):
                return name
            case let .BinaryFunction (name: name, extending: _, onType: _):
                return name
            }
        }
        
        var extending: String? {
            switch self {
            case let .ComputedProperty (name: _, extending: extendingType, onType: _):
                return extendingType
            case let .VoidFunction (name: _, extending: extendingType, onType: _):
                return extendingType
            case let .UnaryFunction (name: _, extending: extendingType, onType: _):
                return extendingType
            case let .BinaryFunction (name: _, extending: extendingType, onType: _):
                return extendingType
            default:
                return nil
            }
        }
        
        var onType: Bool {
            switch self {
            case let .ComputedProperty (name: _, extending: _, onType: onType):
                return onType
            case let .VoidFunction (name: _, extending: _, onType: onType):
                return onType
            case let .UnaryFunction (name: _, extending: _, onType: onType):
                return onType
            case let .BinaryFunction (name: _, extending: _, onType: onType):
                return onType
            default:
                return false
            }
        }
        
        init(typeString: String, nameString: String) {
            switch typeString {
            case "@infix":
                self = .InfixOperator (name: nameString)
            case "@prefix":
                self = .PrefixOperator (name: nameString)
            case "0":
                self = .VoidFunction (Declaration.parseFunctionName(nameString))
            case "1":
                self = .UnaryFunction (Declaration.parseFunctionName(nameString))
            case "2":
                self = .BinaryFunction (Declaration.parseFunctionName(nameString))
            case "var":
                self = .ComputedProperty (Declaration.parseFunctionName(nameString))
            default:
                fatalError("Did not recognize type string")
            }
        }
        
        static func parseFunctionName(nameString: String) -> (name: String, extending: String?, onType: Bool) {
            if let index = findLast(nameString, ".") {
                let name = nameString[index.successor() ..< nameString.endIndex]
                var extendingType = nameString[nameString.startIndex ..< index]
                var onType = false
                
                if extendingType.hasSuffix(".Type") {
                    onType = true
                    extendingType = extendingType[extendingType.startIndex ..< advance(extendingType.endIndex, -countElements(".Type"))]
                }
                
                return (name: name, extending: extendingType, onType: onType)
            }
            else {
                return (name: nameString, extending: nil, onType: false)
            }
        }
    }
}