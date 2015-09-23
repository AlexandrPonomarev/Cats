//
//  ViewController.swift
//  TestSwift
//
//  Created by User on 21.09.15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: NSArray = NSArray()
    
    let url = "http://private-90f77-cats7.apiary-mock.com/cats"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 48.0/255.0, green: 54.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.title = "Cats"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 36)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 170
        
        let parsedJSON = parseJSON(getJSON(url))
        items = parsedJSON["cats"] as! NSArray
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
        
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:CustomCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell!
        
        let tempDict = items[indexPath.row] as! NSDictionary
        cell.setupCell(tempDict)
        
        return cell
    }
    
    func getJSON(urlToRequest: String) -> NSData
    {
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary
    {
        var jsonResult: NSDictionary = NSDictionary()
        
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        } catch let error as NSError {
            print(error)
        }
        
        return jsonResult
    }
}
