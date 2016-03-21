//
//  ImagesCache.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation
import UIKit

class ImagesCache {
    static let sharedCache = ImagesCache()
    var cache = Dictionary<String,UIImage>()
    func asyncGetImage(path:String?, callback: UIImage? -> Void) {
        if let imgUrl = path {
            if let cached = cache[imgUrl]{
                callback(cached)
                return
            }
            if let url = NSURL(string:imgUrl){
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) {data, _, _ in
                    if let data = data {
                        if let image = UIImage(data: data) {
                            dispatch_async(dispatch_get_main_queue()){
                                self.cache[imgUrl] = image
                                callback(image)
                            }
                        }else{dispatch_async(dispatch_get_main_queue()){
                            callback(nil)
                            }
                        }
                    }else {
                        
                        dispatch_async(dispatch_get_main_queue()){
                            callback(nil)
                        }
                    }
                }
                task.resume()
                return
            }
        }
        callback(nil)
    }

}