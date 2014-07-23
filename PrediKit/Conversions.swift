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
