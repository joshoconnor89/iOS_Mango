//
//  Video.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/19/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import Foundation


struct Video {
    
    let mediaURI: String?
    let thumbnailURL: String?
    let videoid: Int?
    let id: Int?
    let username: String?
    let time: NSDate
    
    init(videoDictionary: [String: AnyObject]) {
        
        mediaURI = videoDictionary["media_uri"] as? String
        thumbnailURL = videoDictionary["thumbnail"] as? String
        videoid = videoDictionary["video_id"] as? Int
        
        let user = videoDictionary["user"] as? NSDictionary
        id = user!["id"] as? Int
        username = user!["username"] as? String
        time = NSDate()
        
    }
}
