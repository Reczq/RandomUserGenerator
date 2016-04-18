//
//  UserCell.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 10/03/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var whitePictureContainer: UIView!
    @IBOutlet weak var viewGenderBackground: UIView!
    @IBOutlet weak var gender: UILabel!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.picture.layer.cornerRadius = CGRectGetHeight(self.picture.frame)/2
        self.picture.layer.masksToBounds = true
        
        self.viewGenderBackground.layer.cornerRadius = CGRectGetHeight(self.viewGenderBackground.frame)/2
        self.viewGenderBackground.layer.masksToBounds = true
        self.viewGenderBackground.layer.borderColor = UIColor.whiteColor().CGColor
        self.viewGenderBackground.layer.borderWidth = 2.0

        self.whitePictureContainer.layer.cornerRadius = CGRectGetHeight(self.whitePictureContainer.frame)/2


        self.selectionStyle = .None
    }
}
