//
//  FontPickerViewController.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 25/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class FontPickerViewController: UIViewController {

    @IBOutlet weak var fontPickerTableViewDelegates: FontPickerTableViewDelegates!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontPickerTableViewDelegates.dataSource = MemeMeAPI.sharedInstance.getAvailableFonts()
    }
}
