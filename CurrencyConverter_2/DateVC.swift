//
//  DateVC.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 26.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class DateVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var curPicker: UIPickerView!
    
    var currencies:[String]=[]
    var historyBase:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencies.sort()
        
        let dateFormater=DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        datePicker.minimumDate = dateFormater.date(from: "01.01.1999")
        datePicker.maximumDate = Date()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let historyVC=segue.destination as? HistoryVC else {return}
        
        let base=historyBase ?? currencies.first
        
        historyVC.api.getData(base: base, symbol: nil, date: datePicker.date, completion: {json in
            
            historyVC.historyData=json
            
            DispatchQueue.main.async {
                historyVC.api.updateUI(label: historyVC.dateLabel, date: historyVC.historyData?.date, tableView: historyVC.tableView, currencies: historyVC.historyData?.rates)
            }
            
        })
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
        historyBase=currencies[row]
    }
    
}
