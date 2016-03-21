//
//  NSDateExtensions.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation

extension NSDate {
    func toPrettyString()->String {
        let diff = NSDate().timeIntervalSinceDate(self)
        let min:Int = Int(floor(diff/60))
        let hour:Int = Int(floor(diff/3600))
        let day:Int = Int(floor(diff/3600/24))
        let week:Int = Int(floor(diff/3600/24/7))
        let year:Int = Int(floor(diff/3600/24/365))
        if year != 0 {
            if year == 1 {
                return String(year) + " year ago"
            }
            return String(year) + " years ago"
        }
        if week != 0 {
            if week == 1 {
                return week.description + " week ago"
            }
            return String(week) + " weeks ago"
        }
        if day != 0 {
            if day == 1 {
                return "yesterday"
            }
            return String(day) + " days ago"
        }
        if hour != 0 {
            if hour == 1 {
                return " 1 hour ago"
            }
            return String(hour) + " hours ago"
        }
        if min != 0 {
            if min == 1 {
                return " just now"
            }
            return String(min) + " minutes ago"
        }
        return "just now"
    }
}

