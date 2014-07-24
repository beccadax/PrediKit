//
//  PrediKitTests.swift
//  PrediKitTests
//
//  Created by Brent Royal-Gordon on 7/8/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation
import XCTest

#if os(OSX)
    import PrediKitMac
#elseif os(iOS)
    import PrediKitiOS
#else
    import PrediKitNotSupported
#endif

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
    
    func testBooleanPredicateLiteral() {
        XCTAssertEqual(NSPredicate.fromClosure { _ in true }.description!, "TRUEPREDICATE", "Boolean literals convert to predicates")
    }
    
    func testExpressionLiterals() {
        XCTAssertEqual(NSExpression.fromClosure { _ in true }.description!, "1", "Boolean literals in NSExpression context convert to expressions")
        XCTAssertEqual(NSExpression.fromClosure { _ in nil }.description!, "nil", "Nil literals convert to expressions")
        XCTAssertEqual(NSExpression.fromClosure { _ in 1 }.description!, "1", "Integer literals convert to expressions")
        XCTAssertEqual(NSExpression.fromClosure { _ in 1.5 }.description!, "1.5", "Double literals convert to expressions")
        XCTAssertEqual(NSExpression.fromClosure { _ in "string" }.description!, "\"string\"", "String literals convert to expressions")
        XCTAssertEqual(NSExpression.fromClosure { _ in [1, 2, 3] }.description!, "{1, 2, 3}", "Array literals convert to expressions")
        XCTAssertEqual(NSExpression.fromClosure { _ in [1: 2, 3: 4] }.description!, "{1 = 2, 3 = 4}", "Dictionary literals convert to expressions")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }    
}
