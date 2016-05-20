//
//  TableViewCell.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/19/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var videoidLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // MARK: Initialization
    
    override func awakeFromNib() {
        //Changes done directly here, we have an object
        self.setUpUI()
    }
    
    func setUpUI(){
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.clipsToBounds = true
    }
}
