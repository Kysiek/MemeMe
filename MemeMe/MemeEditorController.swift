//
//  MemeEditorController
//  MemeMe
//
//  Created by Krzysztof Maciążek on 22/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit


protocol MemeEditorControllerDelegate: class {
    func memeHasBeenEdited(meme: Meme)
}

class MemeEditorController: UIViewController, UINavigationControllerDelegate {

    weak var delegate: MemeEditorControllerDelegate?
    
    @IBOutlet var memeEditorView: MemeEditorView!
    
    var editingMeme: Meme?

    override func viewDidLoad() {
        super.viewDidLoad()
        memeEditorView.delegate = self
        memeEditorView.initTextFields()
        subscribeToKeyboardNotifications()
        
        if let editingMeme = editingMeme {
            memeEditorView.imageView.image = editingMeme.originalImage
            memeEditorView.topTextField.text = editingMeme.topText
            memeEditorView.bottomTextField.text = editingMeme.bottomText
        } else {
            memeEditorView.setInitialState()
        }
        
        //add long press gesture
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MemeEditorController.showFontPickerView(_:)))
        longPressGestureRecognizer.numberOfTapsRequired = 1
        memeEditorView.imageView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeEditorView.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        memeEditorView.updateFont(MemeMeAPI.sharedInstance.getFont())
    }
    
    deinit {
        unsubscribeKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func pickImage(sender: AnyObject) {
        presentPickerController(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    @IBAction func takePhote(sender: AnyObject) {
        presentPickerController(UIImagePickerControllerSourceType.Camera)
    }
    @IBAction func cancelAllChanges(sender: AnyObject) {
        memeEditorView.setInitialState()
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = memeEditorView.generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: {
            self.saveMeme(memedImage)
        })
    }
    func showFontPickerView(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            performSegueWithIdentifier("changeFontSegue", sender: nil)
        }
    }
    
    // MARK: Keyboard notifications
    
    func keyboardWillShow(notification: NSNotification) {
        if memeEditorView.isBottomTextFieldBeingEditing() {
            memeEditorView.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
            memeEditorView.frame.origin.y += 0
    }
    
    private func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: private helpers
    
    private func presentPickerController(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    private func saveMeme(generatedImage: UIImage) {
        if let editingMeme = editingMeme {
            editingMeme.topText = self.memeEditorView.topTextField.text!
            editingMeme.bottomText = self.memeEditorView.bottomTextField.text!
            editingMeme.originalImage = self.memeEditorView.imageView.image!
            editingMeme.memedImage = generatedImage
        } else {
            let generatedMeme = Meme(topText: self.memeEditorView.topTextField.text!,
                                     bottomText: self.memeEditorView.bottomTextField.text!,
                                     originalImage: self.memeEditorView.imageView.image!,
                                     memedImage: generatedImage)
            MemeMeAPI.sharedInstance.saveMeme(generatedMeme)
        }
    }

}
extension MemeEditorController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage? {
            memeEditorView.imageChosen(originalImage)
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
extension MemeEditorController: MemeEditorViewDelegate {
    func hideUIElements() {
        navigationController?.navigationBar.hidden = true
    }
    func showHiddenUIElements() {
        navigationController?.navigationBar.hidden = false
    }
}