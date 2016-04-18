//
//  UIImageView+loadImageFromURL.swift
//  RandomUserGenerator
//
//  Created by Reczq on 3/22/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//
//
import UIKit

extension UIImageView {
    
    func loadImageFromURL(url : String, onCompletion: (UIImage) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            let url = NSURL(string: url)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            dispatch_async(dispatch_get_main_queue()) {
                onCompletion(image!)
            }
        }
    }
}