//
//  FontPickerTableViewDelegates.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 25/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class FontPickerTableViewDelegates: NSObject, UITableViewDataSource, UITableViewDelegate {

    var dataSource: [String]?
    
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.count
        }
        return 0
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let fontCellView = tableView.dequeueReusableCellWithIdentifier("fontCell") as! FontCellView
        if let font = dataSource?[indexPath.row] {
            fontCellView.setFontPreview(font)
            if(MemeMeAPI.sharedInstance.getFont() == font) {
                fontCellView.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                fontCellView.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        return fontCellView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(true, animated: true)
        NSNotificationCenter.defaultCenter().postNotificationName("SetFontNotification", object: self, userInfo: ["font": dataSource![indexPath.row]])
        tableView.reloadData()
    }
}
