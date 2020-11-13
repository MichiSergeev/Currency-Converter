//
//  CommonCurrency.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 13.11.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import Foundation

class CommonCurrency {
    
    static let shared = CommonCurrency()
    var information = { () -> [String:AboutCurrency] in 
        guard let url = Bundle.main.url(forResource: "Common-Currency", withExtension: "json") else {
            return [:]
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let json = try decoder.decode([String:AboutCurrency].self, from: data)
            return json
        } catch {
            print(error)
        }
        
        return [:]
    }()
    
    private init() {
        
    }
    
}
