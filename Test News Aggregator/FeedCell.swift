//
//  FeedCell.swift
//  Test News Aggregator
//
//  Created by Aleksei on 21/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postImageView.image = nil
    }
    func initWithPost(post:FeedPostProtocol){
        titleLabel.text = post.title
        descriptionLabel.text = post.content ?? ""
        ImagesCache.sharedCache.asyncGetImage(post.image){[weak self] image in
            self?.postImageView.image = image
            
        }
        self.dateLabel.text = "Posted " + post.date.toPrettyString()
    }
}