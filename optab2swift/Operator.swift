//
//  Operator.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

class Operator {
    let syntax: Syntax // encompasses the name
    let argumentType: RuntimeType
    let returnType: RuntimeType
    let body: Body
    
    var definition: String {
        let def = syntax.declaration(argumentType: argumentType, returnType: returnType) + " {\n    return " + body.generateCode(operands: syntax.operands) + "\n}"
        return syntax.definitionInScope(definition: def) + "\n\n"
    }
    
    init(syntax: Syntax, argumentType: RuntimeType, returnType: RuntimeType, body: Body) {
        self.syntax = syntax
        self.argumentType = argumentType
        self.returnType = returnType
        self.body = body
    }
    
    convenience init(syntaxTypeString: String, syntaxNameString: String, argumentTypeString: String, returnTypeString: String, bodyTypeString: String, bodyContentString: String) {
        self.init(
            syntax: Syntax(typeString: syntaxTypeString, nameString: syntaxNameString),
            argumentType: RuntimeType(typeString: argumentTypeString),
            returnType: RuntimeType(typeString: returnTypeString),
            body: Body(typeString: bodyTypeString, contentString: bodyContentString))
    }
    
    convenience init(line: String) {
        let parts = split(line.unicodeScalars, { $0.isSpace() }, maxSplit: 6)
        
        self.init(syntaxTypeString: parts[0], syntaxNameString: parts[1], argumentTypeString: parts[2], returnTypeString: parts[3],  bodyTypeString: parts[4], bodyContentString: parts[5])
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
