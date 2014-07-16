//
//  Operator.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

class Operator {
    let declaration: Declaration // encompasses the name
    let argumentType: RuntimeType
    let returnType: RuntimeType
    let body: Body
    
    var definition: String {
        var def = declaration.swiftDeclaration(argumentType: argumentType, anyObjectArguments: [], returnType: returnType) + " {\n    return " + body.generateCode(operands: declaration.operands, anyObjectOperands: []) + "\n}\n"
        if declaration.operands.count >= 2 {
            for i in 0..<declaration.operands.count {
                def += declaration.swiftDeclaration(argumentType: argumentType, anyObjectArguments: [ i ], returnType: returnType) + " {\n    return " + body.generateCode(operands: declaration.operands, anyObjectOperands: [ i ]) + "\n}\n"
            }
        }
        return declaration.definitionInScope(definition: def) + "\n"
    }
    
    init(declaration: Declaration, argumentType: RuntimeType, returnType: RuntimeType, body: Body) {
        self.declaration = declaration
        self.argumentType = argumentType
        self.returnType = returnType
        self.body = body
    }
    
    convenience init(declarationTypeString: String, declarationNameString: String, argumentTypeString: String, returnTypeString: String, bodyTypeString: String, bodyContentString: String) {
        self.init(
            declaration: Declaration(typeString: declarationTypeString, nameString: declarationNameString),
            argumentType: RuntimeType(typeString: argumentTypeString),
            returnType: RuntimeType(typeString: returnTypeString),
            body: Body(typeString: bodyTypeString, contentString: bodyContentString))
    }
    
    convenience init(line: String) {
        let parts = split(line.unicodeScalars, { $0.isSpace() }, maxSplit: 5)
        
        self.init(declarationTypeString: parts[0], declarationNameString: parts[1], argumentTypeString: parts[2], returnTypeString: parts[3],  bodyTypeString: parts[4], bodyContentString: parts[5])
    }
    
    class func operatorsWithLines(lines: [String]) -> [Operator] {
        return lines.filter { !$0.isEmpty && $0[$0.startIndex] != "#" }.map { line in
            Operator(line: line)
        }
    }
    
    class func operatorsWithString(string: String) -> [Operator] {
        return operatorsWithLines(split(string) { $0 == "\n" })
    }
}
