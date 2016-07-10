//
//  NewsDetailViewController.swift
//  SPS
//
//  Created by Soriyany keo on 7/10/16.
//  Copyright © 2016 Soriyany keo. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController{
    var newsObject:News!
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDetailContent:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "SPS NEWS DETAIL"
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadData(){
        newsObject.loadCoverImageURL({ (success, image) in
            if success == true{
                self.coverImage.image = image
            }
        })
        newsTitleLabel.text = newsObject.title
        newsDetailContent.loadHTMLString(newsObject.body!, baseURL: nil)
    }
}

