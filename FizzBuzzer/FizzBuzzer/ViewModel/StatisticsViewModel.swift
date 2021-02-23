//
//  StatisticsViewModel.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 23/02/2021.
//

import SwiftUI

class StatisticsViewModel: ObservableObject {
    private let repository: Repository
    private let factory: StatisticsFactory
    
    @Published var formHitStatistics: [FormHitStatistic] = []
    
    init(repository: Repository = FizzBuzzRepository(), factory: StatisticsFactory = FormHitStatisticsFactory.shared) {
        self.repository = repository
        self.factory = factory
        
        self.repository.fizzBuzzParametersHitsPublisher
            .map {
                self.factory.hitForms(from: $0)
            }
            .assign(to: &self.$formHitStatistics)
    }
    
    var totalNumberOfHitTitle : String {
        let total = self.formHitStatistics.reduce(0, { $0 + $1.numberOfHits })
        return "Total: \(total) \(total > 1 ? "hits" : "hit")"
    }
    
    var maxPercentage: Double {
        formHitStatistics.first?.percentage ?? 1.0
    }
    
    func hitDescription(for formHit: FormHitStatistic) -> String {
        "\(formHit.numberOfHits) \(formHit.numberOfHits > 1 ? "hits" : "hit")"
    }
    
    func limitDescription(for formHit: FormHitStatistic) -> String {
        "Limit: \(formHit.limit)"
    }
    
    func mappingDescription(for mapping: ReplacementMapping) -> String {
        "\(mapping.toReplace) → \(mapping.replacement)"
    }
}
