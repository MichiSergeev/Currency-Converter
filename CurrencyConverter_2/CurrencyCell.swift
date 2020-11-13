//
//  CurrencyCell.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 07.11.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    
    func fillCell(cell: CurrencyCell, indexPath: IndexPath, data: Latest) {
        
        let information = CommonCurrency.shared.information
        let base = data.base
        
        let nativeSymbol = information[base]?.symbolNative ?? ""
        
        let sortedData = data.rates.sorted(by: {$0.key < $1.key}).map({($0.key, $0.value)})
        let codes = sortedData.map({$0.0})
        let value = sortedData.map({String(format: "%.02f", 1 / $0.1)})
        let fileName = prepareFileNameForFlag(code: codes[indexPath.row])
        if let image = UIImage(named: fileName) {
            cell.currencyImage.image = image
        }
        let code = codes[indexPath.row]
        if let currency = information[code] {
            cell.currencyLabel.text = currency.name
        }
        cell.codeLabel.text = code
        cell.valueLabel.text = value[indexPath.row] + " \(nativeSymbol)"
    }
  
    private func prepareFileNameForFlag(code: String) -> String {
        
        guard code.count > 2 else {
            return code.lowercased()
        }
        let startIndex = code.startIndex
        let endIndex = code.index(startIndex, offsetBy: 1)
        let fileName = code[startIndex...endIndex].lowercased()
        
        return fileName
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}
