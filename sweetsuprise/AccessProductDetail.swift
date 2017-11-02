//
//  AccessProductDetail.swift
//  sweetsuprise
//
//  Created by Drashti Bhuta on 9/18/17.
//  Copyright © 2017 Drashti Bhuta. All rights reserved.
//

import Foundation
import Alamofire

class AccessProductDetail{
    
    static func fetchpaymentDetails(category:String ,completionHandler:@escaping(_ ifError: Bool, _ result: AnyObject) -> (Void))
    {
        //var objectArray = [CustomerPaymentDetail]()
        var productCatlogue = [ProductDetail]()
        let url = Constants.PRODUCT_API_URL + category
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON{(response) in
                switch(response.result)
                {
                case .failure:
                    debugPrint(response.result)
                    completionHandler(true, "" as AnyObject)
                case .success:
                    if let value = response.result.value as? [String: Any]{
                        if let body = value["body"] as? [String: Any]{
                            if let items = body["Items"] as? [[String: Any]]  {
                                
                                
                                for product in items {
                                    let item = ProductDetail()
                                    if product["ProdName"] != nil{
                                        item.title = product["ProdName"] as! String
                                        print(item.title)
                                        
                                    }
                                    if product["Decription"] != nil{
                                        item.Description = product["Decription"] as! String
                                        
                                    }
                                    
                                    if product["Price"] != nil{
                                        item.Price = product["Price"] as! Int
                                        
                                    }
                                    if product["OrderedTillNow"] != nil{
                                        item.orderedTillNow = product["OrderedTillNow"] as! Int
                                    }
                                    if product["ProdImage"] != nil{
                                        if let images = product["ProdImage"] as? [String]{
                                            item.imagePath = images
                                        }
                                    }
                                    productCatlogue.append(item)
                                }
                                
                                completionHandler(false,productCatlogue as AnyObject)
                            }
                        }
                    }
                }
        }
        
        
    }
        
}
