//
//  MemeEditorController
//  MemeMe
//
//  Created by Krzysztof Maciążek on 22/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var memeEditorView: MemeEditorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        memeEditorView.delegate = self
        memeEditorView.setInitialState()
        memeEditorView.initTextFields()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeEditorView.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
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
    }
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = memeEditorView.generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: {
            MemeMeAPI.sharedInstance.saveImage(Meme(topText: self.memeEditorView.topTextField.text!, bottomText: self.memeEditorView.bottomTextField.text!, originalImage: self.memeEditorView.imageView.image!, memedImage: memedImage))
        })
    }
    
    // MARK: Keyboard notifications
    
    func keyboardWillShow(notification: NSNotification) {
        if memeEditorView.isBottomTextFieldBeingEditing() {
            memeEditorView.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if memeEditorView.isBottomTextFieldBeingEditing() {
            memeEditorView.frame.origin.y += getKeyboardHeight(notification)
            
        }
    }
    
    private func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
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