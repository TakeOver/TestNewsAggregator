//
//  StringExtensions.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation

extension String {
    func deleteHTMLTag(tag:String) -> String {
        guard let range = self.rangeOfString("<\(tag)", options: NSStringCompareOptions.LiteralSearch, range: nil, locale: nil) else{
            return self
        }
        return self.substringToIndex(range.startIndex)
    }
    
    func getURLHTMLTag() -> String? {
        let regex = try! NSRegularExpression(pattern: "https://static(.*).jpg", options: NSRegularExpressionOptions.CaseInsensitive)
        let range = regex.rangeOfFirstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: NSString(string:self).length))
        if range.location == NSNotFound {
            return nil
        }
        return NSString(string:self).substringWithRange(range)
    }
    
    func deleteCossaRuURL() -> String {
        guard let range = self.rangeOfString("http://www.cossa.ru/news/", options: NSStringCompareOptions.LiteralSearch, range: nil, locale: nil) else{
            return self
        }
        return self.substringToIndex(range.startIndex)
    }
    
    func getCossaRuURL() -> String? {
        let regex = try! NSRegularExpression(pattern: "http://www.cossa.ru/news/(.*)/(.*)/", options: NSRegularExpressionOptions.CaseInsensitive)
        let range = regex.rangeOfFirstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSRange(location: 0, length: NSString(string:self).length))
        if range.location == NSNotFound {
            return nil
        }
        return NSString(string:self).substringWithRange(range)
    }
    
}
