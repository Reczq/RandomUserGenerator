//
//  UILabel+Font.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 15/03/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

extension UILabel {
    var substituteFontName : String {
        get { return self.font.fontName }
        set {
                self.font = UIFont(name: "Roboto-Regular", size: self.font.pointSize)
        }
    }
    
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
                self.font = UIFont(name: "Roboto-Regular", size: self.font.pointSize)
        }
    }
}
