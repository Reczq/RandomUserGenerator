//
//  UserDetailsViewController.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 15/03/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    
    var user : User?
    var didEditUser : (User) -> Void = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Details"
        
        self.fillWithUser()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let user = self.user {
            user.name = self.nameTextField.text
            user.username = self.usernameTextField.text
            user.email = self.emailTextField.text
            user.cellNumber = self.phoneTextField.text
            
            self.didEditUser(user)
        }
    }
    
    func fillWithUser() {
        let picURL = user?.picture
        if let user = self.user {
            self.userPhoto.loadImageFromURL(picURL!) { (image: UIImage) -> Void in
                self.userPhoto.image = image
            }
            self.userPhoto.layer.cornerRadius = CGRectGetHeight(self.userPhoto.frame)/2
            self.userPhoto.layer.masksToBounds = true
            self.nameTextField.text = user.name
            self.usernameTextField.text = user.username
            self.emailTextField.text = user.email
            self.phoneTextField.text = user.cellNumber
        }
    }
}
