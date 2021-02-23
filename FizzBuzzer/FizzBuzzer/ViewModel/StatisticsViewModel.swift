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
    }
    
    func load() {
        self.formHitStatistics = self.factory.hitForms(from: self.repository.fizzBuzzParametersHits)
    }
    
    var totalNumberOfHitTitle : String {
        let total = self.formHitStatistics.reduce(0, { $0 + $1.numberOfHits })
        return "Total: \(total) \(total > 1 ? "hits" : "hit")"
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
