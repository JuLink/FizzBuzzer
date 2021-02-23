//
//  FizzBuzzRepository.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 22/02/2021.
//

import Foundation

/**
 Interface for the component responsible of providing the data to the application. It can be data loaded from a database or an API.
 */
public protocol Repository {
    var fizzBuzzParametersHits: [FizzBuzzerParameter: Int] { get }
    var fizzBuzzParametersHitsPublished: Published<[FizzBuzzerParameter: Int]> { get }
    var fizzBuzzParametersHitsPublisher: Published<[FizzBuzzerParameter: Int]>.Publisher { get }
    func addHit(to fizzbuzzParameter: FizzBuzzerParameter)
}

/**
 This component will keep the data in memory for the all lifecycle of the app.
 */
class FizzBuzzRepository: Repository {
    @Published public private(set) var fizzBuzzParametersHits: [FizzBuzzerParameter: Int] = [:]
    var fizzBuzzParametersHitsPublished: Published<[FizzBuzzerParameter: Int]> { _fizzBuzzParametersHits }
    var fizzBuzzParametersHitsPublisher: Published<[FizzBuzzerParameter: Int]>.Publisher { $fizzBuzzParametersHits }
    
    init() {}
    
    public func addHit(to fizzbuzzParameter: FizzBuzzerParameter) {
        let currentNumberOfHit = fizzBuzzParametersHits[fizzbuzzParameter] ?? 0
        fizzBuzzParametersHits[fizzbuzzParameter] = currentNumberOfHit + 1
    }
}
