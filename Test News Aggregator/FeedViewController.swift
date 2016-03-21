//
//  ViewController.swift
//  Test News Aggregator
//
//  Created by Aleksei on 17/03/16.
//  Copyright © 2016 Aleksei Ustimenko. All rights reserved.
//

import UIKit
import SafariServices


class FeedViewController: UITableViewController {
    var vcruProvider = VCRSSProvider()
    var cossaruProvider = FBFeedProvider(page: "cossa.ru")
    var feed:[FeedPostProtocol] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        vcruProvider.onSuccess{[weak self] feed in
            self?.feed += feed
            self?.sortFeed()
            dispatch_async(dispatch_get_main_queue()){
                self?.tableView.reloadData()
            }
            }.onError{ error in
                print(error)
            }.fetch()
        
        FBSDKLoginManager().logInWithReadPermissions([],fromViewController: self){[weak self] _, err in
            if err == nil {
                self?.cossaruProvider.onSuccess{ [weak self] feed in
                    self?.feed += feed
                    NSLog("ok")
                    self?.sortFeed()
                    dispatch_async(dispatch_get_main_queue()){
                        self?.tableView.reloadData()
                    }
                }.onError{ error in
                    print(error)
                }.fetch()
            }
        }
    }
    func sortFeed(){
        feed.sortInPlace({$0.date.compare($1.date) == NSComparisonResult.OrderedDescending})
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as! FeedCell
        cell.initWithPost(feed[indexPath.item])
        cell.sizeToFit()
        cell.updateConstraints()
        cell.layoutIfNeeded()
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let post = feed[indexPath.item]
        guard let url = NSURL(string: post.link) else {
            return
        }
        let sf = SFSafariViewController(URL:url)
        self.presentViewController(sf, animated: true, completion: nil)
    }
}
