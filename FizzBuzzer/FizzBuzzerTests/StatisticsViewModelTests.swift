//
//  StatisticsViewModelTests.swift
//  FizzBuzzerTests
//
//  Created by Julien Lebeau on 23/02/2021.
//

import XCTest
@testable import FizzBuzzer

class StatisticsViewModelTests: XCTestCase {
    
    class FakeRepo: Repository {
        @Published var fizzBuzzParametersHits: [FizzBuzzerParameter : Int]
        var fizzBuzzParametersHitsPublished: Published<[FizzBuzzerParameter : Int]> { _fizzBuzzParametersHits }
        var fizzBuzzParametersHitsPublisher: Published<[FizzBuzzerParameter : Int]>.Publisher { $fizzBuzzParametersHits }
        
        init(numberOfHit: Int = 200) {
            let fakeMapping1 = [
                ReplacementMapping(toReplace: 3, replacement: "Fizz"),
                ReplacementMapping(toReplace: 5, replacement: "Buzz")
            ]
            
            self.fizzBuzzParametersHits = [
                FizzBuzzerParameter(mappings: fakeMapping1, limit: 100) : numberOfHit,
            ]
        }
        
        func addHit(to fizzbuzzParameter: FizzBuzzerParameter) {
            
        }
    }

    func testTotalHitsMultipleString() throws {
        //Given
        let sut = StatisticsViewModel(repository: FakeRepo())
        
        //When
        sut.load()
        
        //Then
        XCTAssertEqual(sut.totalNumberOfHitTitle, "Total: 200 hits")
    }
    
    func testTotalHitsSingleString() throws {
        //Given
        let sut = StatisticsViewModel(repository: FakeRepo(numberOfHit: 1))
        
        //When
        sut.load()
        
        //Then
        XCTAssertEqual(sut.totalNumberOfHitTitle, "Total: 1 hit")
    }
    
    func testMappingDescriptionString() throws {
        //Given
        let sut = StatisticsViewModel(repository: FakeRepo())
        
        //When
        let stringDescription = sut.mappingDescription(for: ReplacementMapping(toReplace: 3, replacement: "Fizz"))
        
        //Then
        XCTAssertEqual(stringDescription, "3 → Fizz")
    }
    
    func testFormHitMultipleHitsDescriptionString() throws {
        //Given
        let sut = StatisticsViewModel(repository: FakeRepo())
        
        //When
        let stringDescription = sut.hitDescription(for: FormHitStatistic(numberOfHits: 10, color: .blue, limit: 20, mappings: [], percentage: 0.2))
        
        //Then
        XCTAssertEqual(stringDescription, "10 hits")
    }
    
    func testFormHitSingleHitDescriptionString() throws {
        //Given
        let sut = StatisticsViewModel(repository: FakeRepo())
        
        //When
        let stringDescription = sut.hitDescription(for: FormHitStatistic(numberOfHits: 1, color: .blue, limit: 20, mappings: [], percentage: 0.2))
        
        //Then
        XCTAssertEqual(stringDescription, "1 hit")
    }
    
    func testFormHitLimitDescriptionString() throws {
        //Given
        let sut = StatisticsViewModel(repository: FakeRepo())
        
        //When
        let stringDescription = sut.limitDescription(for: FormHitStatistic(numberOfHits: 1, color: .blue, limit: 20, mappings: [], percentage: 0.2))
        
        //Then
        XCTAssertEqual(stringDescription, "Limit: 20")
    }

}
