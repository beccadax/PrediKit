//
//  NSFileHandleExtensions.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/12/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension NSFileHandle {
    class func fileHandleOrStandardHandle(forPath path: String, operation: Operation, error: AutoreleasingUnsafePointer<NSError?>) -> NSFileHandle? {
        if path == "-" {
            return operation.standardHandle
        }
        else {
            let URL: NSURL? = NSURL(fileURLWithPath: path)
            return operation.fileHandle(forURL: URL, error: error)
        }
    }
    
    func writeString(string: String) {
        writeData(string.dataUsingEncoding(NSUTF8StringEncoding))
    }
    
    enum Operation {
        case Reading, Writing
        
        var standardHandle: NSFileHandle {
        switch self {
        case .Reading:
            return NSFileHandle.fileHandleWithStandardInput()
        case .Writing:
            return NSFileHandle.fileHandleWithStandardOutput()
            }
        }
        
        func fileHandle(forURL URL: NSURL?, error: AutoreleasingUnsafePointer<NSError?>) -> NSFileHandle? {
            switch self {
            case .Reading:
                return NSFileHandle.fileHandleForReadingFromURL(URL, error: error)
            case .Writing:
                if URL && !(URL!.checkResourceIsReachableAndReturnError(nil)) {
                    // Create the file
                    NSData().writeToURL(URL, options: .DataWritingWithoutOverwriting, error: nil)
                }
                return NSFileHandle.fileHandleForWritingToURL(URL, error: error)
            }
        }
    }
}