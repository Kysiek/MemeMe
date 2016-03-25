//
//  MemeMeAPI.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 22/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit
import Foundation

class MemeMeAPI: NSObject {
    static let sharedInstance = MemeMeAPI()
    
    private var persistencyManager: PersistencyManager!
    
    override init() {
        super.init()
        persistencyManager = PersistencyManager()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeMeAPI.setFont(_:)), name: "SetFontNotification", object: nil)
    }
    
    func saveImage(meme: Meme) {
        persistencyManager.saveImageLocally(meme.memedImage, fileName: "defaultName")
    }
    
    func getAvailableFonts() -> [String] {
        return UIFont.familyNames()
    }
    
    func getFont() -> String {
        return persistencyManager.loadFont() ?? "HelveticaNeue-CondensedBlack"
    }
    
    func setFont(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        if let font = userInfo["font"] as! String? {
            persistencyManager.saveFont(font)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}