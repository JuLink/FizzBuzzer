//
//  FormHitStatisticsFactoryTests.swift
//  FizzBuzzerTests
//
//  Created by Julien Lebeau on 23/02/2021.
//

import XCTest
import SwiftUI
@testable import FizzBuzzer

class FormHitStatisticsFactoryTests: XCTestCase {

    func testFirst20ColorGeneratedAreDifferent() throws {
        //Given
        let sut = FormHitStatisticsFactory()
        
        //When
        let colorGenerated = (0...20).map { index in
            sut.colorAt(index: index)
        }
        
        //Then
        let uniqueColorSet = Set(colorGenerated)
        XCTAssertEqual(colorGenerated.count, uniqueColorSet.count)
    }
    
    func testHitFormStatisticGeneration() throws {
        //Given
        let sut = FormHitStatisticsFactory()
        let mappings = [ReplacementMapping(toReplace: 3, replacement: "Fizz")]
        let limit = 20
        let parameter = FizzBuzzerParameter(mappings: mappings, limit: limit)
        let numberOfHit = 100
        
        //When
        let hitFormStatistics = sut.hitForms(from: [parameter: numberOfHit])
        
        //Then
        XCTAssertEqual(hitFormStatistics.count, 1)
        let firstElement = try XCTUnwrap(hitFormStatistics.first)
        XCTAssertEqual(firstElement.percentage, 1)
        XCTAssertEqual(firstElement.numberOfHits, numberOfHit)
        XCTAssertEqual(firstElement.limit, limit)
        XCTAssertEqual(firstElement.mappings, mappings)
    }

}
