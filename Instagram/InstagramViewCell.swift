//
//  InstagramViewCell.swift
//  
//
//  Created by Gerardo Vazquez on 1/27/16.
//
//

import UIKit

class InstagramViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var InstagramLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
