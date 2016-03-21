//
//  FBFeedProvider.swift
//  Test News Aggregator
//
//  Created by Aleksei on 20/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

final class FBFeedProvider: FeedProvider {
    private var page:String
    typealias CompletionHandler = ([FeedPostProtocol])->Void
    typealias ErrorHandler = (FeedError)->Void
    var complectionHandler:CompletionHandler? = nil
    var errorHandler:ErrorHandler? = nil
    init(page:String){
        self.page = page
    }
    func onSuccess(completionHandler: CompletionHandler) -> FBFeedProvider {
        self.complectionHandler = completionHandler
        return self
    }
    func onError(errorHandler: ErrorHandler) -> FBFeedProvider {
        self.errorHandler = errorHandler
        return self
    }
    func fetch() -> FBFeedProvider {
        let request = FBSDKGraphRequest(graphPath: "/cossa.ru/feed", parameters: ["fields":"message,full_picture,created_time,description,link"], HTTPMethod: "GET")
        request.startWithCompletionHandler{ _, result, _ in
            guard let result = result else {
                self.errorHandler?(FeedError.IncorrectResponse)
                return
            }
            guard let json = result["data"] as? Array<Dictionary<String,AnyObject>> else {
                self.errorHandler?(FeedError.IncorrectResponse)
                return
            }
            var res = [FeedPostProtocol]()
            for i in json {
                guard let title = i["message"] as? String,
                      let time = i["created_time"] as? String,
                      let link = i["link"] as? String else {
                      continue
                }
                let description = i["description"] as? String
                let correctLink = title.getCossaRuURL()
                let correctTitle = title.deleteCossaRuURL()
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
                guard let date = dateFormatter.dateFromString(time) else {
                    continue
                }
                let image = i["full_picture"] as? String
                res.append(FeedPost(date: date, title: correctTitle, content: description,image: image,link: correctLink ?? link))
                
            }
            self.complectionHandler?(res)
        }
        return self
    }
}