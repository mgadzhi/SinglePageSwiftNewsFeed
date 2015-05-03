//
//  Feed.swift
//  SinglePageSwiftNewsFeed
//
//  Created by Gadzhi Musaev on 19.04.15.
//  Copyright (c) 2015 Gadzhi Musaev. All rights reserved.
//

import Foundation

class FeedEntry {
    
    var id: Int
    var author: String
    var title: String
    var body: String
    var categories: [String]
    var timestamp: Int
    
    init() {
        self.id = 0
        self.author = ""
        self.title = ""
        self.body = ""
        self.categories = []
        self.timestamp = 0
    }
    
    init(id: Int, author: String, title: String, body: String, categories: [String], timestamp: Int) {
        self.id = id
        self.author = author
        self.title = title
        self.body = body
        self.categories = categories
        self.timestamp = timestamp
    }
    
    class func fromJSONData(data: NSData) -> FeedEntry? {
        var err: NSError?
        if let entry = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as? NSDictionary {
            if let
                id = entry["id"] as? Int,
                author = entry["author"] as? String,
                title = entry["title"] as? String,
                body = entry["body"] as? String,
                categories = entry["categories"] as? [String],
                timestamp = entry["timestamp"] as? Int {
                    return FeedEntry(id: id, author: author, title: title, body: body, categories: categories, timestamp: timestamp)
            }
        }
        return nil
    }
}

class Feed {
    
    var news: [FeedEntry]
    
    init(entries: [FeedEntry]) {
        self.news = entries
    }
    
    class func fromJSONData(data: NSData) -> Feed? {
        var err: NSError?
        var news = [FeedEntry]()
        if let entries = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as? [[NSString: AnyObject]] {
            for entry in entries {
                if let
                    id = entry["id"] as? Int,
                    author = entry["author"] as? String,
                    title = entry["title"] as? String,
                    categories = entry["categories"] as? [String],
                    timestamp = entry["timestamp"] as? Int {
                        let e = FeedEntry()
                        e.id = id
                        e.author = author
                        e.title = title
                        e.categories = categories
                        e.timestamp = timestamp
                        news.append(e)
                }
            }
            return Feed(entries: news)
        }
        return nil
    }
}