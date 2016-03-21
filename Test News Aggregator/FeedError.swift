//
//  FeedError.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation

enum FeedError:ErrorType {
    case InternetConnection
    case IncorrectFormat
    case IncorrectResponse
    case URLError
}
