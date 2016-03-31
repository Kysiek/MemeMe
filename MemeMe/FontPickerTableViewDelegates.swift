//
//  FontPickerTableViewDelegates.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 25/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class FontPickerTableViewDelegates: NSObject, UITableViewDataSource, UITableViewDelegate {

    var dataSource: [String]!
    var filteredDataSource: [String]!
    
    func filterDataSourceContaining(searchString: String) {
        filteredDataSource = [String]()
        for i in 0..<dataSource.count {
            if searchString.isEmpty || dataSource[i].rangeOfString(searchString) != nil {
                filteredDataSource.append(dataSource[i])
            }
        }
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataSource.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let fontCellView = tableView.dequeueReusableCellWithIdentifier("fontCell") as! FontCellView
        let font = filteredDataSource[indexPath.row]
        fontCellView.setFontPreview(font)
        if(MemeMeAPI.sharedInstance.getFont() == font) {
            fontCellView.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            fontCellView.accessoryType = UITableViewCellAccessoryType.None
        }
        return fontCellView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(true, animated: true)
        NSNotificationCenter.defaultCenter().postNotificationName("SetFontNotification", object: self, userInfo: ["font": filteredDataSource[indexPath.row]])
        tableView.reloadData()
    }
}
