//
//  main.swift
//  optab2swift
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

// "Programs that write programs are the happiest programs of all."
//      —Alan Perlis

import Foundation

let inFile = Process.arguments[1]
let outFile = Process.arguments[2]

var error: NSError?

if let inHandle = NSFileHandle.fileHandleOrStandardHandle(forPath: inFile, operation: .Reading, error: &error) {
    if let outHandle = NSFileHandle.fileHandleOrStandardHandle(forPath: outFile, operation: .Writing, error: &error) {
        let inputData = inHandle.readDataToEndOfFile()
        let inputString = NSString(data: inputData, encoding: NSUTF8StringEncoding)
        
        for op in Operator.operatorsWithString(inputString) {
            let outputString = op.definition
            let outputData = outputString.dataUsingEncoding(NSUTF8StringEncoding)
            outHandle.writeData(outputData)
        }
    }
    else {
        debugPrintln("Can't open \(outFile): \(error?.localizedDescription)")
        exit(EXIT_FAILURE)        
    }
}
else {
    debugPrintln("Can't open \(outFile): \(error?.localizedDescription)")
    exit(EXIT_FAILURE)
}
