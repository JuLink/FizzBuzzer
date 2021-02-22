//
//  FizzBuzzModelTests.swift
//  FizzBuzzerTests
//
//  Created by Julien Lebeau on 22/02/2021.
//

import XCTest
@testable import FizzBuzzer

class FizzBuzzModelTests: XCTestCase {
    static let fizzString = "Fizz"
    static let buzzString = "Buzz"
    static let fizzBuzzString = "FizzBuzz"
    
    static let mappings = [
        ReplacementMapping(toReplace: 3, replacement: fizzString),
        ReplacementMapping(toReplace: 5, replacement: buzzString)
    ]
    
    static let parameters = FizzBuzzerParameter(mappings: mappings,
                                         limit: 16)
    
    func testFizzReplacement() throws {
        //Given
        let sut = FizzBuzzer(parameters: Self.parameters)
        
        //When
        let result = sut.fizzBuzz(number: 3)
        
        //Then
        let fizzBuzzedString = try XCTUnwrap(result)
        XCTAssertEqual(fizzBuzzedString, Self.fizzString)
    }
    
    func testBuzzReplacement() throws {
        //Given
        let sut = FizzBuzzer(parameters: Self.parameters)
        
        //When
        let result = sut.fizzBuzz(number: 5)
        
        //Then
        let fizzBuzzedString = try XCTUnwrap(result)
        XCTAssertEqual(fizzBuzzedString, Self.buzzString)
    }
    
    func testFizzBuzzReplacement() throws {
        //Given
        let sut = FizzBuzzer(parameters: Self.parameters)
        
        //When
        let result = sut.fizzBuzz(number: 15)
        
        //Then
        let fizzBuzzedString = try XCTUnwrap(result)
        XCTAssertEqual(fizzBuzzedString, Self.fizzBuzzString)
    }
    
    func testNonReplacement() throws {
        //Given
        let sut = FizzBuzzer(parameters: Self.parameters)
        
        //When
        let result = sut.fizzBuzz(number: 4)
        
        //Then
        let fizzBuzzedString = try XCTUnwrap(result)
        XCTAssertEqual(fizzBuzzedString, "4")
    }

    func testFizzBuzzSequence() throws {
        //Given
        let sut = FizzBuzzer(parameters: Self.parameters)
        
        //When
        let fizzbuzzed = (0...20).compactMap {
            sut.fizzBuzz(number: $0)
        }
        
        //Then
        let expectedResult = [
            "1",
            "2",
            Self.fizzString,
            "4",
            Self.buzzString,
            Self.fizzString,
            "7",
            "8",
            Self.fizzString,
            Self.buzzString,
            "11",
            Self.fizzString,
            "13",
            "14",
            Self.fizzBuzzString,
            "16"
        ]
        XCTAssertEqual(fizzbuzzed.count, 16)
        XCTAssertEqual(fizzbuzzed, expectedResult)
    }

}
