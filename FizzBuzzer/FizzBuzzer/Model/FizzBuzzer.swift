//
//  FizzBuzzer.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 22/02/2021.
//

import Foundation

public struct ReplacementMapping: Hashable, Equatable {
    let toReplace: Int
    let replacement: String
}

public struct FizzBuzzerParameter: Hashable, Equatable {
    let mappings: [ReplacementMapping]
    let limit: Int
}

struct FizzBuzzer {
    let parameters: FizzBuzzerParameter
    
    init(parameters: FizzBuzzerParameter) {
        self.parameters = parameters
    }
    
    func fizzBuzz(number: Int) -> String? {
        guard number <= self.parameters.limit && number > 0 else {
            return nil
        }
        
        var fizzBuzzedString = ""
        
        self.parameters.mappings.forEach { mapping in
            if number.isMultiple(of: mapping.toReplace) {
                fizzBuzzedString.append(mapping.replacement)
            }
        }
        
        if fizzBuzzedString.isEmpty {
            fizzBuzzedString = "\(number)"
        }
        
        return fizzBuzzedString
    }
}

