//
//  HomeTableViewController.swift
//  sweetsuprise
//
//  Created by Drashti Bhuta on 9/15/17.
//  Copyright © 2017 Drashti Bhuta. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBAction func giftsClicked(_ sender: Any) {
        performSegue(withIdentifier: "giftSegue", sender: sender)
        ProductsTableViewController.type = "Gift"
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
       
}
