//
//  Conversions.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/22/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension NSPredicate: BooleanLiteralConvertible {
    public class func convertFromBooleanLiteral(value: Bool) -> Self {
        return self(value: value)
    }
}

extension NSExpression: BooleanLiteralConvertible, NilLiteralConvertible, StringLiteralConvertible, IntegerLiteralConvertible, FloatLiteralConvertible, ArrayLiteralConvertible, DictionaryLiteralConvertible {
    public class func convertFromBooleanLiteral(value: Bool) -> Self {
        return self(forConstantValue: value)
    }
    
    public class func convertFromNilLiteral() -> Self {
        return self(forConstantValue: nil)
    }
    
    public class func convertFromStringLiteral(value: String) -> Self {
        return self(forConstantValue: value)
    }
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: Character) -> Self {
        return self(forConstantValue: String(value))
    }
    
    public class func convertFromIntegerLiteral(value: Int) -> Self {
        return self(forConstantValue: value)
    }
    
    public class func convertFromFloatLiteral(value: Double) -> Self {
        return self(forConstantValue: value)
    }
    
    public class func convertFromArrayLiteral(elements: AnyObject...) -> Self {
        return self(forConstantValue: elements)
    }
    
    public class func convertFromDictionaryLiteral(elements: (NSObject, AnyObject)...) -> Self {
        var dictionary = [NSObject: AnyObject]()
        for (key, value) in elements {
            dictionary[key] = value
        }
        return self(forConstantValue: dictionary)
    }
}
