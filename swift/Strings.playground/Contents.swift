import Foundation
import XCTest

/**
 Reverses an Int32 if the reversed value is within the limits.
 */
func reverseInt(_ x: Int32) -> Int32 {
    guard x != 0 else {
        return 0
    }
    
    var num: Int32 = Int32(x)
    var reversed: Int32 = 0
    
    while num != 0 {
        let units = num % 10
        num /= 10
        
        let multiplied = reversed.multipliedReportingOverflow(by: 10)
        guard !multiplied.overflow else {
            return 0
        }
        
        let added = multiplied.partialValue.addingReportingOverflow(units)
        guard !added.overflow else {
            return 0
        }
        reversed = added.partialValue
    }
    
    return Int32(reversed)
}

final class StringTests: XCTestCase {
    
    var input: Int32 = 0
    var expected: Int32 = 0
    var actual: Int32 = 0
    
    func test_reverseInt_0() {
        input = 0
        expected = 0
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_1() {
        input = 1
        expected = 1
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_minus1() {
        input = -1
        expected = -1
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_positive() {
        input = 1234
        expected = 4321
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_negative() {
        input = -97531
        expected = -13579
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_2power31Minus1_fails() {
        input = 2147483647
        expected = 0
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_negative_2power31_fails() {
        input = -2147483648
        expected = 0
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
    
    func test_reverseInt_positiveLarge_fails() {
        input = 1534236469
        expected = 0
        actual = reverseInt(input)
        XCTAssertEqual(expected, actual)
    }
}

StringTests.defaultTestSuite.run()
