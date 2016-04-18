//
//  String+Capitalize.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 15/03/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

extension String {
    var first: String {
        return String(characters.prefix(1))
    }

    var uppercaseFirst: String {
        return first.uppercaseString + String(characters.dropFirst())
    }
}
