//
//  ProductTableViewCell.swift
//  sweetsuprise
//
//  Created by Drashti Bhuta on 9/19/17.
//  Copyright © 2017 Drashti Bhuta. All rights reserved.
//

import UIKit
import ImageSlideshow

class ProductTableViewCell: UITableViewCell {

 
    @IBOutlet weak var prodImageSlideshow: ImageSlideshow!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var productCellView: UIView!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var btnEnquire: UIButton!
        @IBOutlet weak var lblPrice: UILabel!
   
    @IBOutlet weak var descriptionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnReadMore.layer.cornerRadius = 50
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    func configureSlideShow(localSource:[AlamofireSource]){
        
        prodImageSlideshow.backgroundColor = UIColor.white
        prodImageSlideshow.slideshowInterval = 12.0
        prodImageSlideshow.pageControlPosition = PageControlPosition.hidden
//        prodImageSlideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
//        prodImageSlideshow.pageControl.pageIndicatorTintColor = UIColor.black
        prodImageSlideshow.contentScaleMode = UIViewContentMode.scaleToFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        prodImageSlideshow.activityIndicator = DefaultActivityIndicator()
        prodImageSlideshow.currentPageChanged = { page in
            //print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        prodImageSlideshow.setImageInputs(localSource)
        
        //let recognizer = UITapGestureRecognizer(target: self, action: #selector(ProductTableViewCell.didTap))
        //prodImageSlideshow.addGestureRecognizer(recognizer)
    }
//    func didTap() {
//        let fullScreenController = prodImageSlideshow.presentFullScreenController(from: ProductTableViewCell)
//        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
//        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
//    }

}
