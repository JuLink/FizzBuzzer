//
//  FizzBuzzFormViewModel.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 22/02/2021.
//

import Foundation

class FizzBuzzFormViewModel {
    private let dataProvider: Repository
    
    var int1: Int?
    var int2: Int?
    var limit: Int?
    var str1: String?
    var str2: String?
    
    init(dataProvider: Repository = FizzBuzzRepository()) {
        self.dataProvider = dataProvider
    }
    
    var isFormValid: Bool {
        return self.int1 != nil &&
            self.int2 != nil &&
            self.limit != nil &&
            self.str1 != nil &&
            self.str1?.isEmpty == false &&
            self.str2 != nil &&
            self.str2?.isEmpty == false
    }
    
    var fizzbuzzParameter: FizzBuzzerParameter? {
        guard let int1Value = self.int1,
              let int2Value = self.int2 ,
              let limit = self.limit,
              let string1Value = self.str1,
              let string2Value = self.str2 else {
            return nil
        }
        
        let mappings = [
            ReplacementMapping(toReplace: int1Value, replacement: string1Value),
            ReplacementMapping(toReplace: int2Value, replacement: string2Value)
        ]
        return FizzBuzzerParameter(mappings: mappings,
                                   limit: limit)
    }
    
    func formValidated() {
        if let parameters = fizzbuzzParameter {
            self.dataProvider.addHit(to: parameters)
        }
    }
}
