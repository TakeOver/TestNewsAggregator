//
//  FeedPost.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation

struct FeedPost:FeedPostProtocol {
    var date:NSDate
    var title:String
    var content:String?
    var image:String?
    var link:String
}
