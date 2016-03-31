//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 28/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    var meme: Meme!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memedImage
    }
    
    @IBAction func editMeme(sender: AnyObject) {
        performSegueWithIdentifier("editMemeSegue", sender: meme as AnyObject)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editMemeSegue" {
            let memeEditorController = (segue.destinationViewController as! UINavigationController).topViewController as! MemeEditorController
            memeEditorController.editingMeme = sender as? Meme
            memeEditorController.delegate = self
        }
    }
}
extension MemeDetailsViewController: MemeEditorControllerDelegate {
    func memeHasBeenEdited(meme: Meme) {
        self.meme = meme
    }
}