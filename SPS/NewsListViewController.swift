//
//  ViewController.swift
//  SPS
//
//  Created by Soriyany keo on 7/10/16.
//  Copyright © 2016 Soriyany keo. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var data:NSArray?
    var dataCount:Int = 0
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadData(){
        let url:String = REQUESTURL + "news"
        let getJson:GetJSONRequest = GetJSONRequest(url: url)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            getJson.getNewsList{ (results) in
                if results != nil{
                    self.dataCount = results!.count
                    self.data = results
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableview.reloadData()
                    }
                }
            }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newsCell")! as UITableViewCell
        let newsObject:News = data![indexPath.row] as! News
        let newsTitle:UILabel = cell.viewWithTag(100) as! UILabel
        newsTitle.text = newsObject.title
        
        let newsSummary:UILabel = cell.viewWithTag(101) as! UILabel
        newsSummary.text = newsObject.summary
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newsDetailVC:NewsDetailViewController =  storyboard.instantiateViewControllerWithIdentifier("newsDetailVC") as! NewsDetailViewController
        newsDetailVC.newsObject = data![indexPath.row] as! News
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}

