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
    
    var latestData: Latest? {
        didSet {
            if let data = latestData {
                let base = data.base
                latestData!.rates.removeValue(forKey: base)
            }
        }
    }
    var api = RatesApi()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        api.getData(base: nil, symbol: nil, date: nil, completion: {json in
            self.latestData = json
            DispatchQueue.main.async {
                self.api.updateUI(label: self.dateLabel,
                                  date: self.latestData?.date,
                                  tableView: self.tableView,
                                  currencies: self.latestData?.rates)
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
        
        return data.rates.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        guard let data = latestData else {
            return cell
        }
        cell.fillCell(cell: cell, indexPath: indexPath, data: data)
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
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
