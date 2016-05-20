//
//  Network
//  iOS_Mango
//
//  Created by Joshua O'Connor on 5/18/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

import Foundation


class Network {
    

    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    init(url: NSURL) {
        self.queryURL = url
    }

    typealias JSONDictionaryCompletion = ([String: AnyObject]? -> Void)
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        
        let request = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data!, options: [])) as? [String: AnyObject]
                    completion(jsonDictionary)
                default:
                    print("GET request failed")
                }
            } else {
                print("Error")
            }
        }
        dataTask.resume()
    }
}
