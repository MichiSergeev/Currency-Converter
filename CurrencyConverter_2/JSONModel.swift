//
//  JSONModel.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 23.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import Foundation

struct Latest: Decodable {
    let base: String
    var rates: [String : Double]
    let date: String
}

//struct AboutCurrency: Decodable {
//    let symbol: String
//    let name: String
//    let symbol_native: String
//    let decimal_digits: Double
//    let rounding: Double
//    let code: String
//    let name_plural: String
//}

struct AboutCurrency: Decodable {
    let symbol: String
    let name: String
    let symbolNative: String
    let decimalDigits: Double
    let rounding: Double
    let code: String
    let namePlural: String
}
