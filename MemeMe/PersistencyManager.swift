//
//  PersistencyManager.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 22/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation
import UIKit

class PersistencyManager {
    
    static let FONT_KEY = "fontKey"
    
    func saveImageLocally(imageToSave: UIImage, fileName: String) {
        //This method should save a given image
        //It is no implemented yet, as there is no reason for it in the currect application version
    }
    
    func loadFont() -> String? {
        let variable = NSUserDefaults().objectForKey(PersistencyManager.FONT_KEY) as! String?
        return variable
    }
    
    func saveFont(font: String) {
        NSUserDefaults().setObject(font, forKey: PersistencyManager.FONT_KEY)
    }
    
}