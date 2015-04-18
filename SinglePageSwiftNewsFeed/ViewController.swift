//
//  ViewController.swift
//  SinglePageSwiftNewsFeed
//
//  Created by Gadzhi Musaev on 12.04.15.
//  Copyright (c) 2015 Gadzhi Musaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        self.tableData.append(["title": "Title 1", "author": "Ivan"])
        self.tableData.append(["title": "Title 2", "author": "Maria"])
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let dataEntry = self.tableData[indexPath.row]
        cell.textLabel!.text = dataEntry["title"] as String?
        cell.detailTextLabel!.text = dataEntry["author"] as String?
        return cell
    }

}

