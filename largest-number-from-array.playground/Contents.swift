//: 
//: Original source for problem => https://www.shiftedup.com/2015/05/07/five-programming-problems-every-software-engineer-should-be-able-to-solve-in-less-than-1-hour

import Cocoa
import XCTest

func largestNumberComposed(from: Array<Int>) -> Int {
   return Int(from.map{String($0)}.sort{$0+$1>$1+$0}.joinWithSeparator(""))!
}
/// tests

XCTAssertEqual(9, largestNumberComposed(from: [9]))

XCTAssertEqual(90, largestNumberComposed(from: [9,0]))

XCTAssertEqual(910, largestNumberComposed(from: [10,9]))

XCTAssertEqual(56554, largestNumberComposed(from: [54,5,56]))

