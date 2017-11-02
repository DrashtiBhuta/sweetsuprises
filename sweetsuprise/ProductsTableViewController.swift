//
//  ProductsTableViewController.swift
//  sweetsuprise
//
//  Created by Drashti Bhuta on 9/18/17.
//  Copyright © 2017 Drashti Bhuta. All rights reserved.
//

import UIKit
import ImageSlideshow
import MessageUI

class ProductsTableViewController: UITableViewController,MFMailComposeViewControllerDelegate {
    
    public static var type:String = ""
    var height : CGFloat = 0.0
    
    enum DataState: String {
        case loading
        case noData
        case available
    }
    
    @IBOutlet var productTableView: UITableView!
    var catalogue = [ProductDetail]()
    var dataState: DataState = .noData
    var shouldCellBeExpanded:Bool = false
    var indexOfExpendedCell:NSInteger = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataState = .loading
        self.productTableView.separatorStyle = .none
        getProducts{(error,result)->Void in
            if error
            {
                print("something went wrong")
            }
            else
            {
                if let details = result as? [ProductDetail]
                {
                    //self.displayData(object: details)
                    self.dataState = .available
                    self.catalogue = details
                    self.productTableView.reloadData()
                }
                
            }
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func getProducts(completionHandler: @escaping(_ ifError: Bool, _ result: AnyObject) -> (Void))
    {
        AccessProductDetail.fetchpaymentDetails(category: ProductsTableViewController.type) {(error,result) -> (Void) in
            if error {
                print("cannot fetch access payment Detail")
            }
            else{
                if let details = result as? [ProductDetail]
                {
                    completionHandler(false,details as AnyObject)
                    
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return catalogue.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldCellBeExpanded && section == indexOfExpendedCell {
            return 2
        }
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "productDetail", for: indexPath)  as? ProductTableViewCell
            {
                let item = catalogue[indexPath.section]
                var imageSource = [AlamofireSource]()
                for image in item.imagePath {
                    imageSource.append(AlamofireSource(urlString: image)!)
                }
                
                cell.configureSlideShow(localSource: imageSource)
                cell.lblName.text = item.title
                cell.lblPrice.text = "Price: ₹ " + String(item.Price)
                cell.btnReadMore.tag = indexPath.section
                cell.btnEnquire.addTarget(self, action: #selector(self.showEmailView), for: .touchUpInside)
                cell.btnReadMore.addTarget(self, action: #selector(self.expandButtonAction1), for: .touchUpInside)
                return cell
            }
 
        }
        if (indexPath.row == 1){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "productDescription", for: indexPath)  as? ProductDescriptionTableViewCell{
                let item = catalogue[indexPath.section]
                cell.lblDescription.numberOfLines = 0
                cell.lblDescription.sizeToFit()
                let value = item.Description + "\n\n" + String(item.orderedTillNow) + " people purchased"
                
                //cell.lblDescription.attributedText = str
                
                return cell
            }
            
        }
        
        return UITableViewCell()
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 250.0
        }
        else{return 160.0}
    }
    
    func expandButtonAction1(button:UIButton){
        shouldCellBeExpanded = !shouldCellBeExpanded
        indexOfExpendedCell = button.tag
        
        if shouldCellBeExpanded {
            self.productTableView.beginUpdates()
            
            let indexPath = IndexPath(row: 1 , section: button.tag)
            tableView.insertRows(at: [indexPath], with: .fade)
            self.productTableView.endUpdates()
            
            button.setTitle("Read Less", for: UIControlState.normal)
        }
            
        else {
            self.productTableView.beginUpdates()
            let indexPath = IndexPath(row: 1 , section: button.tag)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.productTableView.endUpdates()
            
            button.setTitle("Read More", for: UIControlState.normal)
        }
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["drashti.232@gmail.com"])
        mailComposerVC.setSubject("Order Enquiry")
        mailComposerVC.setMessageBody("Hi Team!\n\nI would like to share the following feedback..\n", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
            
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled mail")
        case MFMailComposeResult.sent.rawValue:
            print("Mail Sent")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    func showEmailView(){
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

    }


}
