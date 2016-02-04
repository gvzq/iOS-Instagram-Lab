//
//  ViewController.swift
//  Instagram
//
//  Created by Gerardo Vazquez on 1/27/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    
    var pictures: [NSDictionary]!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramViewCell
        
        let photo = pictures![indexPath.row]
        let poster = (photo["images"])!["low_resolution"]!!["url"]! as! String
        let title = (photo["user"])!["username"]! as! String
        let profile = (photo["user"])!["profile_picture"]! as! String
        
        let imageURL = NSURL(string: poster)
        cell.posterView.setImageWithURL(imageURL!)
        cell.InstagramLabel.text = title
        let profileURL = NSURL(string: profile)
        cell.profileView.setImageWithURL(profileURL!)
        return cell

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pictures = pictures{
            return pictures.count
        } else {
            return 0
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                            
                            self.pictures = responseDictionary["data"] as? [NSDictionary]
                            
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

