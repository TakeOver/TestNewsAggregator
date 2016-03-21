//
//  VCRSSProvider.swift
//  Test News Aggregator
//
//  Created by Aleksei on 19/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation
import Muon

final class VCRSSProvider:FeedProvider {
    private var parser:FeedParser! = nil
    typealias CompletionHandler = ([FeedPostProtocol])->Void
    typealias ErrorHandler = (FeedError)->Void
    var complectionHandler:CompletionHandler? = nil
    var errorHandler:ErrorHandler? = nil
    var task:NSURLSessionDataTask? = nil
    func onSuccess(completionHandler: CompletionHandler) -> VCRSSProvider {
        self.complectionHandler = completionHandler
        return self
    }
    func onError(errorHandler: ErrorHandler) -> VCRSSProvider {
        self.errorHandler = errorHandler
        return self
    }
    func fetch() -> VCRSSProvider {
        guard let url = NSURL(string: "https://vc.ru/feed") else {
            errorHandler?(FeedError.URLError)
            return self
        }
        let request = NSURLRequest(URL: url)
        task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, _, _ in
            guard let data = data else {
                self.errorHandler?(FeedError.InternetConnection)
                return
            }
            guard let content = String(data:data,encoding:NSUTF8StringEncoding) else {
                self.errorHandler?(FeedError.IncorrectResponse)
                return
            }
            self.parse(content)
        }
        task!.resume()
        return self
    }
    private func parse(content:String){
        parser = FeedParser(string: content)
        parser.onFailure = { _ in
                self.errorHandler?(FeedError.IncorrectFormat)
        }
        parser.success { feed in
            var res = [FeedPostProtocol]()
            for i in feed.articles {
                guard let published = i.published,
                let title = i.title,
                let link = i.link?.description
                    else {
                    continue
                }
                
                res.append(FeedPost(date: published, title: title, content: i.description?.deleteHTMLTag("img"),image: i.description?.getURLHTMLTag(), link: link))
            }
            self.complectionHandler?(res)
        }
        parser.main()
    }
}