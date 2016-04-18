//
//  PeopleViewController.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 3/5/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

private let reusableCellIdentifier = "userCell"

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addUserButton: UIButton!
    
    let restApiManager = RestApiManager()
    var users : [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .None
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: reusableCellIdentifier)
        self.tableView.rowHeight = 70
        
        self.prepareNavigationBar()
        
        self.addDummyData(10)
    }
    
    func prepareNavigationBar() {
        self.navigationItem.title = "Users"

        let rightButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Add, target: self, action: "addOnePerson")
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationController?.navigationBar.backgroundColor? = UIColor.redColor()
    }
    
    func addOnePerson() {
        self.addDummyData(1)
    }
    
    func addDummyData(count : Int) {
        self.navigationItem.rightBarButtonItem!.enabled = false
        let onCompletion : (JSON) -> Void = { (jsonFromAPI : JSON?) -> Void in
            if let json = jsonFromAPI {
                let results: JSON = json["results"]
                
                for user in results.arrayValue {
                    let userObject = User(json: user)
                    self.users.insert(userObject, atIndex: 0)
                }

                dispatch_async(dispatch_get_main_queue()) {                    
                    if count == 1 {
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                    } else {
                        self.tableView?.reloadData()
                    }
                    self.navigationItem.rightBarButtonItem!.enabled = true
                }
            } else {
                self.showAddDummyErrorAlertView()
            }
        }
        
        self.restApiManager.generateRandomUsers(count: count, onCompletion: onCompletion)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UserCell = tableView.dequeueReusableCellWithIdentifier(reusableCellIdentifier) as! UserCell
        
        let user : User = self.users[indexPath.row]
        cell.name.text = user.name
        cell.username.text = user.username
        cell.date.text = user.createdAt
        
        let gender : Gender = user.gender!
        var genderCharacter = ""
        
        switch gender {
        case .Female:
            genderCharacter = "♀"
            cell.picture.image = UIImage(named: "placeholderF.jpg")
            cell.viewGenderBackground.layer.backgroundColor = UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 0.35).CGColor
            break
        case .Male:
            genderCharacter = "♂"
            cell.picture.image = UIImage(named: "placeholderM.jpg")
            cell.viewGenderBackground.layer.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 1.0, alpha: 0.35).CGColor
//            cell.gender.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            break
        case .Undefined:
            genderCharacter = "⚤"
            cell.picture.image = UIImage(named: "placeholderU.jpg")
            cell.viewGenderBackground.layer.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 0.35).CGColor
            break
        }
        cell.gender.text = genderCharacter

        let picURL = user.picture
        cell.picture.alpha = 0.3

//        self.loadImageFromURL(picURL!) { (image: UIImage) -> Void in
//            cell.picture.image = image
//            cell.picture.alpha = 1.0
//        }
        cell.picture.loadImageFromURL(picURL!) { (image: UIImage) -> Void in
                        cell.picture.image = image
                        cell.picture.alpha = 1.0
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("details", sender: nil)
    }
    
    func showAddDummyErrorAlertView() {
        let alert : UIAlertController = UIAlertController(title: "Error", message: "Cannot add new user", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
//    func loadImageFromURL(url : String, onCompletion: (UIImage) -> Void) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
//            let url = NSURL(string: url)
//            let data = NSData(contentsOfURL: url!)
//            let image = UIImage(data: data!)
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                onCompletion(image!)
//            }
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let userDetailsViewController : UserDetailsViewController = segue.destinationViewController as? UserDetailsViewController {
            
            let indexPath = self.tableView.indexPathForSelectedRow
            userDetailsViewController.user = self.users[indexPath!.row]
            userDetailsViewController.didEditUser = { (user : User) -> Void in
                
                self.users[indexPath!.row] = user
                self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .None)
            }
        }
        
    }
}

