//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 27/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController {
    
    var dataSource: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(SentMemesViewController.pushMemeEditorController))
        navigationItem.title = "Sent memes"
        
        dataSource = MemeMeAPI.sharedInstance.getSavedMemes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = MemeMeAPI.sharedInstance.getSavedMemes()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMemeDetailsSegue" {
            let memeDetailsViewController = segue.destinationViewController as! MemeDetailsViewController
            memeDetailsViewController.meme = sender as! Meme
        }
    }
    
    func pushMemeEditorController() {
        performSegueWithIdentifier("memeEditorSegue", sender: nil)
    }
}
