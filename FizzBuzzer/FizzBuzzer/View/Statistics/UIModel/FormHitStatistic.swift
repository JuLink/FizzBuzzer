//
//  FormHitStatistic.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 23/02/2021.
//

import SwiftUI

struct FormHitStatistic: Identifiable {
    let numberOfHits: Int
    let color: Color
    let limit: Int
    let mappings: [ReplacementMapping]
    let percentage: Double
    
    var id: String {
        "\(numberOfHits)_\(limit)_\(mappings.map{"\($0.toReplace) -> \($0.replacement)"}.joined())"
    }
}
