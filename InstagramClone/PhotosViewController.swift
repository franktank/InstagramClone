//
//  ViewController.swift
//  InstagramClone
//
//  Created by Franky Liang on 1/14/16.
//  Copyright © 2016 Franky Liang. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate	 {

    @IBOutlet weak var tableView: UITableView!
    
    
    var users: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                           self.users = responseDictionary["data"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                    
                }
        });
        task.resume()
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let users = users {
            return users.count
        }
        
        else{
        return 0
        }
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        
        let user = users![indexPath.row]
        
       
        
        let imagePath = user["images"]!["standard_resolution"]!!["url"] as! String
        
        let imageURL = NSURL(string: imagePath)
        
        cell.posterView.setImageWithURL(imageURL!)
        
        
        print("row \(indexPath.row)")
        
        return cell
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

