//
//  CommonUI.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/19/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import UIKit

class CommonUI: NSObject {

    func getUserImage(username: String) -> String {
        
        var imageString: String
        switch username {
        case "Al":
            imageString = "al.png"
            
        case "Paul":
            imageString = "paul.png"
            
        case "George":
            imageString = "george.png"
            
        default:
            imageString = "john.png"
        }
        
        return imageString
    }
}
