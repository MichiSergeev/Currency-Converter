//
//  DateVC.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 26.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class DateVC: UIViewController {


    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormater=DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        datePicker.minimumDate = dateFormater.date(from: "01.01.1999")
        datePicker.maximumDate = Date()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let historyVC=segue.destination as? HistoryVC else {return}
        historyVC.api.getData(base: nil, symbol: nil, date: datePicker.date, completion: {json in
            
            historyVC.historyData=json
            
            DispatchQueue.main.async {
                historyVC.api.updateUI(label: historyVC.dateLabel, date: historyVC.historyData?.date, tableView: historyVC.tableView, currencies: historyVC.historyData?.rates)
            }
            
        })
    }
}
