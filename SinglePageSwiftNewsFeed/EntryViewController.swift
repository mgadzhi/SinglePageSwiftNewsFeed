//
//  EntryViewController.swift
//  SinglePageSwiftNewsFeed
//
//  Created by Denis Engels on 03/05/15.
//  Copyright (c) 2015 Gadzhi Musaev. All rights reserved.
//

import UIKit

class EntryViewController : UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://carrick.ru/news/van-gaal-persie-oy-oy/")
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
