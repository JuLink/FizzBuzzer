//
//  FizzBuzzFormViewModelTests.swift
//  FizzBuzzerTests
//
//  Created by Julien Lebeau on 22/02/2021.
//

import XCTest
@testable import FizzBuzzer

class FakeRepo: Repository {
    var numberOfCallToAdd = 0
    @Published var fizzBuzzParametersHits: [FizzBuzzerParameter : Int] = [:]
    var fizzBuzzParametersHitsPublished: Published<[FizzBuzzerParameter : Int]> { _fizzBuzzParametersHits }
    var fizzBuzzParametersHitsPublisher: Published<[FizzBuzzerParameter : Int]>.Publisher { $fizzBuzzParametersHits }
    func addHit(to fizzbuzzParameter: FizzBuzzerParameter) {
        numberOfCallToAdd += 1
    }
}

class FizzBuzzFormViewModelTests: XCTestCase {

    func testFormIsNotValid() throws {
        //Given
        let sut = FizzBuzzFormViewModel(dataProvider: FakeRepo())
        
        //When
        sut.int1 = 0
        
        //Then
        XCTAssertFalse(sut.isFormValid)
    }
    
    func testFormIsNotValidBecauseStringAreEmpty() throws {
        //Given
        let sut = FizzBuzzFormViewModel(dataProvider: FakeRepo())
        
        //When
        sut.int1 = 0
        sut.int2 = 1
        sut.limit = 1
        sut.str1 = ""
        sut.str2 = ""

        //Then
        XCTAssertFalse(sut.isFormValid)
    }
    
    func testFormIsValid() throws {
        //Given
        let sut = FizzBuzzFormViewModel(dataProvider: FakeRepo())
        
        //When
        sut.int1 = 0
        sut.int2 = 1
        sut.limit = 1
        sut.str1 = "fizz"
        sut.str2 = "buzz"

        //Then
        XCTAssertTrue(sut.isFormValid)
    }
    
    func testCreateParameter() throws {
        //Given
        let sut = FizzBuzzFormViewModel(dataProvider: FakeRepo())
        sut.int1 = 3
        sut.int2 = 5
        sut.limit = 16
        sut.str1 = "fizz"
        sut.str2 = "buzz"
        
        //When
        let parameter = sut.fizzbuzzParameter
        
        //Then
        let unwrappedParameter = try XCTUnwrap(parameter)
        XCTAssertEqual(unwrappedParameter.limit, 16)
        
        let expectedParameter1 = ReplacementMapping(toReplace: 3, replacement: "fizz")
        let expectedParameter2 = ReplacementMapping(toReplace: 5, replacement: "buzz")
        XCTAssertTrue(unwrappedParameter.mappings.contains(expectedParameter1))
        XCTAssertTrue(unwrappedParameter.mappings.contains(expectedParameter2))
    }
    
    func testAddingHitToRepo() throws {
        //Given
        let fakeRepo = FakeRepo()
        let sut = FizzBuzzFormViewModel(dataProvider: fakeRepo)
        sut.int1 = 3
        sut.int2 = 5
        sut.limit = 16
        sut.str1 = "fizz"
        sut.str2 = "buzz"
        
        //When
        sut.formValidated()
        
        //Then
        XCTAssertEqual(fakeRepo.numberOfCallToAdd, 1)
    }

}
