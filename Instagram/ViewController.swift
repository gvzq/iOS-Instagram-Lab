//
//  ViewController.swift
//  Instagram
//
//  Created by Gerardo Vazquez on 1/27/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {


    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    
    var pictures: [NSDictionary]!
    var isMoreDataLoading = false
    
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
    
    //this is not working!
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
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
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let picture = pictures![indexPath!.row]
        
        
//        var vc = segue.destinationViewController as! ViewController
//        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        
        let photoDetailsViewController = segue.destinationViewController as! PhotoDetailsViewController
        photoDetailsViewController.vc = picture
        
//        PhotoDetailsViewController.vc = vc
//        PhotoDetailsViewController.indexPath = indexPath

        // Pass the selected object to the new view controller.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                loadMoreData()
            }
        }
    }
    
//    func loadMoreData() {
//        
//        // ... Create the NSURLRequest (myRequest) ...
//        
//        // Configure session so that completion handler is executed on main UI thread
//        let session = NSURLSession(
//            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
//            delegate:nil,
//            delegateQueue:NSOperationQueue.mainQueue()
//        )
//        
//        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
//            completionHandler: { (data, response, error) in
//                
//                // Update flag
//                self.isMoreDataLoading = false
//                
//                // ... Use the new data to update the data source ...
//                
//                // Reload the tableView now that there is new data
//                self.myTableView.reloadData()
//        });
//        task.resume()
//    }
    
    func loadMoreData() {
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        //Show HUD before the request is made
        //let HUDindicator = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        //HUDindicator.labelText = "Loading"
        //HUDindicator.detailsLabelText = "Please wait"
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                
                // Update flag
                self.isMoreDataLoading = false
                
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





}

