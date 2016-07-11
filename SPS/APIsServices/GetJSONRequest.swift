//
//  GetJSONRequest.swift
//  SPS
//
//  Created by Soriyany keo on 7/10/16.
//  Copyright © 2016 Soriyany keo. All rights reserved.
//

import Foundation
class GetJSONRequest {
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    let urlstring:String!
    
    init(url:String){
        self.urlstring = url
    }
    
    func getNewsList(completionHandler: (NSArray?) -> ()) {
        if dataTask != nil {
            dataTask!.cancel()
        }
        if let encodedString = urlstring.stringByAddingPercentEncodingWithAllowedCharacters(
            NSCharacterSet.URLFragmentAllowedCharacterSet()),
            url = NSURL(string: encodedString) {
            dataTask = defaultSession.dataTaskWithURL(url) {
                data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
                else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        self.parseServerData(data!, response: response, error: error, completionHandler: { (dataArr) in
                            var resultArr = [News]()
                            for result in dataArr!{
                                if result.valueForKey("id") != nil{
                                    let newsObject:News = News(newsObject: result as! NSDictionary)
                                    resultArr.append(newsObject)
                                }
                            }
                            completionHandler(resultArr)
                        })
                    }
                    else{
                        completionHandler(nil)
                        print("server error.")
                    }
                }
            }
            
            dataTask!.resume()
        }
    }
    func parseServerData(data: NSData?, response: NSURLResponse?, error: NSError?,completionHandler: (NSArray?) -> ()) {
        do {
            let dataArr = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
            completionHandler(dataArr)
        }
        catch{
            completionHandler(nil)
            print("Unexpected data format provided by server.")
        }
    }
}