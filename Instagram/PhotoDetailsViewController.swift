//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Gerardo Vazquez on 2/3/16.
//  Copyright © 2016 Gerardo Vazquez. All rights reserved.
//

import UIKit
import GoogleMobileAds

class PhotoDetailsViewController: UIViewController {

    var vc : NSDictionary!
    //var indexPath: NSIndexPath?

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView.adUnitID = "ca-app-pub-9883927867094729/4670122164"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        
        let poster = (vc["images"])!["low_resolution"]!!["url"]! as! String
        let title = (vc["user"])!["username"]! as! String
//        let profile = (vc["user"])!["profile_picture"]! as! String
        
        let imageURL = NSURL(string: poster)
        posterView.setImageWithURL(imageURL!)
        instagramLabel.text = title
//        let profileURL = NSURL(string: profile)
//        profileView.setImageWithURL(profileURL!)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
