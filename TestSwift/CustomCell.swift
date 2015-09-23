//
//  CustomCell.swift
//  TestSwift
//
//  Created by User on 21.09.15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var porodaLabel: UILabel!

    var placeIm: String = ""
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping

        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5

        porodaLabel.adjustsFontSizeToFitWidth = true
        porodaLabel.minimumScaleFactor = 0.3

        placeImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func setupCell(tempDict: NSDictionary)
    {
        nameLabel?.text = (tempDict["name"] as! String)
        descriptionLabel?.text = (tempDict["description"] as! String)
        
        var infoText = String()
        
        if (tempDict["age"]?.description != nil && tempDict["age"]?.description != "<null>") {
            infoText = "Возраст: " + (tempDict["age"]?.description)! + " мес."
        }
        
        if (tempDict["weight"]?.description != nil && tempDict["weight"]?.description != "<null>") {
            if infoText.isEmpty {
                infoText = "Вес: " + (tempDict["weight"]?.description)! + " гр."
            } else {
                infoText += " Вес: " + (tempDict["weight"]?.description)! + " гр."
            }
        }
        
        if (tempDict["length"]?.description != nil && tempDict["length"]?.description != "<null>") {
            if infoText.isEmpty {
                infoText = "Длина: " + (tempDict["length"]?.description)! + " см."
            } else {
                infoText += " Длина: " + (tempDict["length"]?.description)! + " см."
            }
        }
        
        if !infoText.isEmpty && infoLabel != nil {
            infoLabel.text = infoText
        } else if infoLabel != nil {
            infoLabel.removeFromSuperview()
        }
        
        if (tempDict["breed"]?.description != nil && tempDict["breed"]?.description != "<null>") && porodaLabel != nil {
            porodaLabel.text = "Порода: " + (tempDict["breed"]?.description)!
        } else if porodaLabel != nil {
            porodaLabel.removeFromSuperview()
        }
        
        
        if let url = NSURL(string: (tempDict["image_url"] as! String)) {
            getDataFromUrl(url) { data in
                dispatch_async(dispatch_get_main_queue()) {
                    let image = UIImage(data: data!)
                    if image != nil {
                        self.placeImage.image = image
                    }
                }
            }
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
}