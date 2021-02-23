//
//  FormHitFactory.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 23/02/2021.
//

import SwiftUI

protocol StatisticsFactory {
    func hitForms(from fizzBuzzParametersHits: [FizzBuzzerParameter: Int]) -> [FormHitStatistic]
}

class FormHitStatisticsFactory: StatisticsFactory {
    static let shared = FormHitStatisticsFactory()
    
    func hitForms(from fizzBuzzParametersHits: [FizzBuzzerParameter: Int]) -> [FormHitStatistic] {
        
        let sortedFizzBuzzHit = fizzBuzzParametersHits.map{ (parameter, hitCount) in
            return (parameter, hitCount)
        }.sorted(by: { $0.1 > $1.1 })
        
        let totalHits = sortedFizzBuzzHit.reduce(0, { $0 + $1.1 })
        
        let formHits = sortedFizzBuzzHit.enumerated().map { index, fizzBuzzHit -> FormHitStatistic in
            let percentage = Double(fizzBuzzHit.1) / Double(totalHits)
            return FormHitStatistic(numberOfHits: fizzBuzzHit.1,
                                    color: colorAt(index: index),
                                    limit: fizzBuzzHit.0.limit,
                                    mappings: fizzBuzzHit.0.mappings,
                                    percentage: percentage)
        }

        return formHits
    }
    
    func colorAt(index: Int) -> Color {
        let hueWheelDivisions = 12
        let wheelTurnCount = index / hueWheelDivisions

        let hue = Double(index % hueWheelDivisions) / Double(hueWheelDivisions)
        
        let saturation = 0.8 - (0.2 * Double(wheelTurnCount))

        return Color(hue: hue, saturation: saturation, brightness: 1.0)
    }
}
