//
//  FeedPostProtocol.swift
//  Test News Aggregator
//
//  Created by Aleksei on 17/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation
import UIKit

protocol FeedPostProtocol {
    var date:NSDate{
        get
    }
    var title:String {
        get
    }
    var content:String? {
        get
    }
    var image:String? {
        get
    }
    var link:String {
        get
    }
}
