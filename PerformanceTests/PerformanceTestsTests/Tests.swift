//
//  Tests.swift
//  PerformanceTestsTests
//
//  Created by Antonio Tanzola on 11/08/2016.
//  Copyright © 2016 Antonio Tanzola. All rights reserved.
//

import XCTest
@testable import PerformanceTests

class CorrectnessTests: XCTestCase
{
    func test() {
        let originalArray = Array(1...10000)
        let solution1 = nLogNTimeStringBuilder(withIntegers: originalArray)
        let solution2 = linearTimeStringBuilder(withIntegers: originalArray)
        
        XCTAssert(solution1 == solution2)
    }
}

class PerformanceTests: XCTestCase
{
    func testNLogNSolution() {
        let originalArray = Array(1...200000)
        self.measure {
            _ = nLogNTimeStringBuilder(withIntegers: originalArray)
        }
    }
    
    func testLinearSolution() {
        let originalArray = Array(1...200000)
        self.measure {
            _ = linearTimeStringBuilder(withIntegers: originalArray)
        }
    }
}
