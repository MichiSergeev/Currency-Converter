//
//  HistoryVC.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 23.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class HistoryVC: UITableViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    var api=RatesApi()
    var historyData:Latest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getData(base: nil, symbol: nil, date: nil, completion: {json in
            self.historyData=json
            print("Пришло с сервера \(json.rates.count)")
            DispatchQueue.main.async {
                guard let l=self.historyData else {return}
                self.api.updateUI(label: self.dateLabel, date: l.date, tableView: self.tableView, currencies: l.rates)
            }
        })
        
    }
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {return 1}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data=historyData else {return 0}
        var dic=data.rates
        let base=data.base
        dic.removeValue(forKey: base)
        print("Настройка числа ячеек \(dic.count)")
        return dic.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath)
        guard let data=historyData else {return cell}
        var newData=data.rates
        newData.removeValue(forKey: data.base)
        let sortedData = newData.sorted(by: {$0.key<$1.key}).map({($0.key, $0.value)})
        let currency=sortedData.map({$0.0})
        let value=sortedData.map({String(format: "%.02f", $0.1)})
        cell.textLabel?.text="1 "+data.base + " ="
        cell.detailTextLabel?.text = value[indexPath.row] + " " + currency[indexPath.row]        
        return cell
    }

    func updateUI(tableView: UITableView, label:UILabel, date:String?)->() {
        tableView.reloadData()
        label.text=date
    }
    
    @IBAction func unwidHistoryVC(_ unwindSegue: UIStoryboardSegue) {}
    
}
