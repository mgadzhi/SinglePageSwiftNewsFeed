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
    var timestamp: Int
    var title: String
    
    init(id: Int, timestamp: Int, title: String) {
        self.id = id
        self.timestamp = timestamp
        self.title = title
    }
    
    class func fromJSONData(data: NSData) -> FeedEntry? {
        var err: NSError?
        if let entry = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as? NSDictionary {
            if let
                id = entry["id"] as? Int,
                timestamp = entry["timestamp"] as? Int,
                title = entry["title"] as? String{
                    return FeedEntry(id: id, timestamp: timestamp, title: title)
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
            for e in entries {
                if let
                    id = e["id"] as? Int,
                    timestamp = e["timestamp"] as? Int,
                    title = e["title"] as? String {
                        news.append(FeedEntry(id: id, timestamp: timestamp, title: title))
                }
            }
            return Feed(entries: news)
        }
        return nil
    }
}