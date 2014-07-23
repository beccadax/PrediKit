//
//  PrediKitTests.swift
//  PrediKitTests
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation
import XCTest
import PrediKitMac

class PrediKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicPredicate() {
        XCTAssertEqual(NSPredicate.fromClosure { $0 == 1 }.description!, "SELF == 1", "Predicate tests that self equals 1")
    }
    
    func testKeyPathPredicate() {
        XCTAssertEqual(NSPredicate.fromClosure { $0["value"] == 1 }.description!, "value == 1", "Predicate tests that self.value equals 1")
    }
    
    func testExpressionPredicate() {
        XCTAssertEqual(NSPredicate.fromClosure { $0["nextStep"] == $0["step"] + 1 }.description!, "nextStep == step + 1", "Predicate tests that self.value equals 1")
    }

    func testCompoundPredicate() {
        XCTAssertEqual(NSPredicate.fromClosure { $0 == "hello" && $0["value"] == 1 }.description!, "SELF == \"hello\" AND value == 1", "Predicate tests that self.value equals 1")
    }
    
    func testTruePredicate() {
        XCTAssertEqual(NSPredicate.fromClosure { _ in true }.description!, "TRUEPREDICATE", "Boolean literals convert to predicates")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }    
}
