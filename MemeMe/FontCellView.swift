//
//  FontCellView.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 25/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class FontCellView: UITableViewCell {
    @IBOutlet weak var fontPreviewTextField: UITextField!
    
    func setFontPreview(fontName: String) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.whiteColor(),
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: fontName, size: 40)!,
            NSStrokeWidthAttributeName : -1
            
        ]
        fontPreviewTextField.defaultTextAttributes = memeTextAttributes
        fontPreviewTextField.textAlignment = .Center
        fontPreviewTextField.text = fontName
    }
}
