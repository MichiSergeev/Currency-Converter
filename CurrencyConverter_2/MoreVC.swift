//
//  MoreVC.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 23.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class MoreVC: UITableViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Public property
    
    var latestData: Latest?
    var api = RatesApi()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getData(base: nil, symbol: nil, date: nil, completion: {json in
            self.latestData = json
            DispatchQueue.main.async {
                self.api.updateUI(label: self.dateLabel, date: self.latestData?.date, tableView: self.tableView, currencies: self.latestData?.rates)
            }
        })
        
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = latestData else {
            return 0
        }
        var dic = data.rates
        let base = data.base
        dic.removeValue(forKey: base)
        return dic.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let data = latestData else {
            return cell
        }
        
        print(data)
        
        var newData = data.rates
        newData.removeValue(forKey: data.base)
        let sortedData = newData.sorted(by: {$0.key < $1.key}).map({($0.key, $0.value)})
        let currency = sortedData.map({$0.0})
        let value = sortedData.map({String(format: "%.02f", 1 / $0.1)})
        cell.textLabel?.text = "1 " + data.base + " ="
        cell.detailTextLabel?.text = value[indexPath.row] + " " + currency[indexPath.row]
        return cell
    }

    // MARK: - Public Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let baseVC = segue.destination as? BaseVC {
            guard let data = latestData else {
                return
            }
            baseVC.currencies = Array((data.rates.keys))
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func unwindMoreVC(unwindSegue: UIStoryboardSegue) {
    }
    
}


// MARK: - Extansion
