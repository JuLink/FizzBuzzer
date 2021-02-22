//
//  FizzBuzzListViewModel.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 22/02/2021.
//

import Foundation

class FizzBuzzListViewModel {
    let fizzBuzzer: FizzBuzzer
    
    init(fizzbuzzParameter: FizzBuzzerParameter) {
        self.fizzBuzzer = FizzBuzzer(parameters: fizzbuzzParameter)
    }
    
    var numberOfElement: Int {
        self.fizzBuzzer.parameters.limit
    }
    
    func string(for indexPath: IndexPath) -> String {
        self.fizzBuzzer.fizzBuzz(number: indexPath.row + 1) ?? ""
    }
}
