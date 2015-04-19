//
//  ViewController.swift
//  SinglePageSwiftNewsFeed
//
//  Created by Gadzhi Musaev on 12.04.15.
//  Copyright (c) 2015 Gadzhi Musaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView : UITableView!

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
            var err: NSError?
            let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err)
            let entries = json as! [[String: AnyObject]]
            for entry in entries {
                if let
                  id    = entry["id"]    as? Int,
                  title = entry["title"] as? String {
                    self.tableData.append(["title": title])
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        networkTask.resume()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let dataEntry = self.tableData[indexPath.row]
        cell.textLabel!.text = dataEntry["title"] as String?
        return cell
    }

}

