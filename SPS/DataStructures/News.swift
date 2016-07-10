//
//  News.swift
//  SPS
//
//  Created by Soriyany keo on 7/10/16.
//  Copyright © 2016 Soriyany keo. All rights reserved.
//

import Foundation
import UIKit
class News {
    var id:String?
    var brand_id:String?
    var title:String?
    var summary:String?
    var body:String?
    var coverLG:String?
    var coverMD:String?
    var coverSM:String?
    init(newsObject:NSDictionary){
        //mapJSONToResaurantObject
        self.id = newsObject.valueForKey("id") as? String
        self.brand_id = newsObject.valueForKey("brand_id") as? String
        self.title = newsObject.valueForKey("title") as? String
        self.summary = newsObject.valueForKey("summary") as? String
        self.body = newsObject.valueForKey("body") as? String
        let coverImageDict:NSDictionary = newsObject.valueForKey("cover") as! NSDictionary
        self.coverLG = coverImageDict.valueForKey("lg") as? String
        self.coverMD = coverImageDict.valueForKey("md") as? String
        self.coverSM = coverImageDict.valueForKey("sm") as? String
    }
    func loadCoverImageURL(completionHandler: (success:Bool,image:UIImage)->Void){
        NSURLSession.sharedSession().dataTaskWithURL( NSURL(string:self.coverLG!)!, completionHandler: {
            (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                var image:UIImage = UIImage()
                if let data = data {
                    image = UIImage(data: data)!
                    completionHandler(success: true,image: image)
                }
                else{
                    completionHandler(success: false,image: image)
                }
            }
        }).resume()
    }
}