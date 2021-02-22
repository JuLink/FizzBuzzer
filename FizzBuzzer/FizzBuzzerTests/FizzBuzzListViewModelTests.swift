//
//  FizzBuzzListViewModelTests.swift
//  FizzBuzzerTests
//
//  Created by Julien Lebeau on 22/02/2021.
//

import XCTest
@testable import FizzBuzzer

class FizzBuzzListViewModelTests: XCTestCase {
    static let fizzString = "Fizz"
    static let buzzString = "Buzz"
    static let fizzBuzzString = "FizzBuzz"
    
    static let mappings = [
        ReplacementMapping(toReplace: 3, replacement: fizzString),
        ReplacementMapping(toReplace: 5, replacement: buzzString)
    ]
    
    static let parameters = FizzBuzzerParameter(mappings: mappings,
                                         limit: 16)

    func testNumberOfElement() throws {
        //Given
        let sut = FizzBuzzListViewModel(fizzbuzzParameter: Self.parameters)
        
        //Then
        XCTAssertEqual(sut.numberOfElement, 16)
    }
    
    func testStringForElementInListIsNotEmpty() throws {
        //Given
        let sut = FizzBuzzListViewModel(fizzbuzzParameter: Self.parameters)
        
        //When
        let stringToDisplay = sut.string(for: IndexPath(row: 5, section: 0))
        
        //Then
        XCTAssertFalse(stringToDisplay.isEmpty)
    }
    
    func testStringForElementNotInListIsEmpty() throws {
        //Given
        let sut = FizzBuzzListViewModel(fizzbuzzParameter: Self.parameters)
        
        //When
        let stringToDisplay = sut.string(for: IndexPath(row: 500, section: 0))
        
        //Then
        XCTAssertTrue(stringToDisplay.isEmpty)
    }
}
