//
//  BaseVC.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 25.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var currencies: [String]=[]
    var newBase: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencies.sort()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newBase = currencies[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mvc = segue.destination as? MoreVC {
            
            let base = newBase ?? currencies.first
            
            mvc.api.getData(base: base, symbol: nil, date: nil, completion: {json in
                
                mvc.latestData = json
                
                DispatchQueue.main.async {
                    mvc.api.updateUI(label: mvc.dateLabel, date: mvc.latestData?.date, tableView: mvc.tableView, currencies: mvc.latestData?.rates)
                }
            })
        }
    }
}
