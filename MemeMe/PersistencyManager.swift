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
    
    private var memes: [Meme]!
    
    init() {
        memes = [Meme]()
    }
    
    func saveMeme(meme: Meme) {
        if !checkMemeAlreadyContained(meme) {
            memes.append(meme)
        }
    }
    func deleteMeme(memeToDelete: Meme) {
        for i in 0..<memes.count {
            if memes[i] === memeToDelete {
                memes.removeAtIndex(i)
                return
            }
        }
    }
    func loadSavedMemes() -> [Meme] {
        return memes
    }
    
    func loadFont() -> String? {
        let variable = NSUserDefaults().objectForKey(PersistencyManager.FONT_KEY) as! String?
        return variable
    }
    
    func saveFont(font: String) {
        NSUserDefaults().setObject(font, forKey: PersistencyManager.FONT_KEY)
    }
    
    private func checkMemeAlreadyContained(meme: Meme) -> Bool {
        for i in 0..<memes.count {
            if memes[i] === meme {
                return true
            }
        }
        return false
    }
    
}