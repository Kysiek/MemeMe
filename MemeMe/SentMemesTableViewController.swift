//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 27/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class SentMemesTableViewController: SentMemesViewController {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
extension SentMemesTableViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memeDetailsTableViewCell = tableView.dequeueReusableCellWithIdentifier("memeDetailsTableViewCell") as! MemeDetailsTableViewCell
        memeDetailsTableViewCell.setMemeText(dataSource[indexPath.row].topText, bottomText: dataSource[indexPath.row].bottomText)
        memeDetailsTableViewCell.setMemeImage(dataSource[indexPath.row].memedImage)
        return memeDetailsTableViewCell
    }
}
extension SentMemesTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMemeDetailsSegue", sender: dataSource[indexPath.row] as AnyObject)
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            MemeMeAPI.sharedInstance.deleteMeme(dataSource[indexPath.row])
            dataSource = MemeMeAPI.sharedInstance.getSavedMemes()
            tableView.reloadData()
        }
    }
}
