//
//  DynamicVariables.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

struct DynamicVariables {
    var supportedVariables: [String]
    
    init(supportedVariables: [String]) {
        self.supportedVariables = supportedVariables
    }
    
    subscript (variableName: String) -> NSExpression {
        assert(find(supportedVariables, variableName), "Variable must be among supported variables")
        return NSExpression(forVariable: variableName)
    }
}
