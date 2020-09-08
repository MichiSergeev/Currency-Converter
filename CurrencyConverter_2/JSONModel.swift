//
//  JSONModel.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 23.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import Foundation


struct Latest:Decodable {
    let base:String
    let rates:[String:Double]
    let date:String
}


struct Top:Decodable {
    let currency : Currency
}

struct Currency:Decodable {
//    let symbol:String
//    let name:String
//    let symbol_native:String
//    let decimal_digits:Int
//    let rounding:Int
//    let code:String
    let name_plural:String
}
