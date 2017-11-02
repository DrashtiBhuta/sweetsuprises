//
//  HomeViewController.swift
//  sweetsuprise
//
//  Created by Drashti Bhuta on 9/29/17.
//  Copyright © 2017 Drashti Bhuta. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBAction func btnBirthdayClicked(_ sender: Any) {
        performSegue(withIdentifier: "giftSegue", sender: sender)
        ProductsTableViewController.type = "Gift"

    }
    @IBAction func btnAnniversaryClicked(_ sender: Any) {
    }
    @IBAction func btnProposalClicked(_ sender: Any) {
    }
    @IBAction func btnValentineClicked(_ sender: Any) {
    }
    @IBAction func btnBabyShowerClicked(_ sender: Any) {
    }
    @IBAction func btnSuprisesClicked(_ sender: Any) {
    }
    @IBAction func btnNightClicked(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = "sundaye"
        print(str.uppercased())
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    
    
}
