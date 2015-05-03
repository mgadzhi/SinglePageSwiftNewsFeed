//
//  ViewController.swift
//  SinglePageSwiftNewsFeed
//
//  Created by Gadzhi Musaev on 12.04.15.
//  Copyright (c) 2015 Gadzhi Musaev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var tableData: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchRemoteData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchRemoteData() {
        let address = "http://api-trololo.rhcloud.com/list.json"
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: address)!

        let networkTask = mySession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            var entries = [FeedEntry]()
            if let feed = Feed.fromJSONData(data){
                entries = feed.entries
            }
            for entry in entries {
                self.tableData.append(["title": entry.title])
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        networkTask.resume()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell") as! UITableViewCell
        let dataEntry = self.tableData[indexPath.row]
        cell.textLabel!.text = dataEntry["title"] as String?
        return cell
    }

}

