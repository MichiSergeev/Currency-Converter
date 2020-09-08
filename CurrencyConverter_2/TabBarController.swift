//
//  TabBarController.swift
//  CurrencyConverter_2
//
//  Created by Mikhail Sergeev on 23.08.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, URLSessionDelegate {
    
    var x=0
    var y=1
    var z=2
    
    var api=RatesApi()
    var latestExchangeRate:[String:Double] = [:]
    var currentData=Date()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vcs=viewControllers {
            for vc in vcs {
                if let nc = vc as? UINavigationController {
                    nc.navigationBar.prefersLargeTitles = true
                }
            }
        }
        
//        if let pathB=Bundle.main.path(forResource: "Common-Currency", ofType: "json") {
//            let url=URL(string: pathB)
//             print(url)
//            let data = try? Data(contentsOf: url!)
//
//            let myData = try? JSONDecoder().decode([Currency].self, from: data!)
//            print(myData)
//
//        }
        
      
        
//        let jsonURL=Bundle.main.url(forResource: "Common-Currency", withExtension: "json")
//        
//        if let url=jsonURL {
//            let myData = try? Data(contentsOf: url)
//            if let data=myData {
//                let json = try? JSONDecoder().decode(Top.self, from: data)
//                print(json)
//            }
//        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
////     указываю мой вкладки
//    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
//        let first=FavoritesVC()
//        self.viewControllers?.append(first)
//    }
    
}
