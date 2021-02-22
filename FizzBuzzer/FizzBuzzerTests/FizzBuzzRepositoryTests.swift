//
//  FizzBuzzRepositoryTests.swift
//  FizzBuzzerTests
//
//  Created by Julien Lebeau on 22/02/2021.
//

import XCTest
@testable import FizzBuzzer

class FizzBuzzRepositoryTests: XCTestCase {

    func testRepositoryHitCount() throws {
        //Given
        let parameterToAdd = FizzBuzzerParameter(mappings: [], limit: 0)
        let sut = FizzBuzzRepository()
        XCTAssertEqual(sut.fizzBuzzParametersHits[parameterToAdd], nil)
        
        //When
        sut.addHit(to: parameterToAdd)
        
        //Then
        XCTAssertEqual(sut.fizzBuzzParametersHits[parameterToAdd], 1)
    }

}
