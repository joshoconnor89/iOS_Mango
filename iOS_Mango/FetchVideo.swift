//
//  VideoData.swift
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/19/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import Foundation


struct FetchVideo {

    func getVideo(videoURL: NSURL, completion: (Video? -> Void))  {

        let networkOperation = Network(url: videoURL)
        networkOperation.downloadJSONFromURL {
            (let JSONDictionary) in
            let currentVideo = self.currentVideoFromJSONDictionary(JSONDictionary)
            completion(currentVideo)
        }
    }
    
    func currentVideoFromJSONDictionary(jsonDictionary: [String: AnyObject]?) -> Video? {
        
        if (jsonDictionary == nil){
            print("JSON is nil")
            return nil
        }
        else{
            return Video(videoDictionary: jsonDictionary!)
        }
    }

}