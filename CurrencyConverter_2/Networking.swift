//
//  Networking.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 23.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import Foundation
import UIKit

struct RatesApi {
    
//    var data: [String:Double] = [:]
//    var date: Date?=Date()
    var defaultBase: String? = "RUB"
//    var symbol: [String]?
//    var latestExchangeRate: [String:Double]?
    
    func getData (base: String?, symbol: [String]?, date: Date?, completion: @escaping (Latest) -> ()) {
        
        var urlComponents: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.ratesapi.io"
            components.path = "/api/"
            return components
        }()
        
        var queryItems: [URLQueryItem] = []
        
        if let d = date {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            urlComponents.path += df.string(from: d)
        } else {
            urlComponents.path += "latest"
        }
        
        
        let baseQueryItem = base == nil ? URLQueryItem(name: QueryParameters.base.rawValue, value: self.defaultBase) : URLQueryItem(name: QueryParameters.base.rawValue, value: base!)
        queryItems.append(baseQueryItem)
        
        if let s = symbol {
            for currency in s {
                let symbolQuery = URLQueryItem(name: QueryParameters.symbols.rawValue, value: currency)
                queryItems.append(symbolQuery)
            }
        }
        
        if !queryItems.isEmpty {urlComponents.queryItems = queryItems}

        guard let url = urlComponents.url else {
            print("url invalid")
            return}
        
        print(url.absoluteString)
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let latestData = data {
                
                do {
                    let json = try JSONDecoder().decode(Latest.self, from: latestData)
                    completion(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    // делает строковую дату для метки
    func settingDate(_ stringDate: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        let mbDate = formater.date(from: stringDate)
        formater.locale = Locale(identifier: "ru_RUS")
        formater.dateStyle = .full
        guard let date = mbDate else {
            return "некорректная дата"
        }
        return formater.string(from: date)
    }
    
    // обновляет таблицу и метку
    func updateUI(label: UILabel, date: String?, tableView: UITableView, currencies: [String:Double]?) -> () {
            tableView.reloadData()
        guard let d = date else {
            return
        }
        label.text = self.settingDate(d)
    }
}

enum QueryParameters: String {
    case symbols
    case base
    case date
}

