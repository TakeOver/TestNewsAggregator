//
//  FeedProvider.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation

protocol FeedProvider {
    typealias CompletionHandler = ([FeedPostProtocol])->Void
    typealias ErrorHandler = (FeedError)->Void
    func onSuccess(completionHandler:CompletionHandler) -> Self
    func onError(errorHandler:ErrorHandler) -> Self
    func fetch() -> Self
}

