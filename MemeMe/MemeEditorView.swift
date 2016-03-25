//
//  MemeEditorView.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 23/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

@objc protocol MemeEditorViewDelegate {
    func hideUIElements()
    func showHiddenUIElements()
}

class MemeEditorView: UIView {

    weak var delegate: MemeEditorViewDelegate?
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButtom: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    func initTextFields() {
        initTextField(topTextField)
        initTextField(bottomTextField)
    }
    
    func isBottomTextFieldBeingEditing() -> Bool {
        return bottomTextField.editing
    }
    
    func generateMemedImage() -> UIImage {
        
        hideNavbarAndToolbar()
        
        UIGraphicsBeginImageContext(frame.size)
        drawViewHierarchyInRect(frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        showNavbarAndToolbar()
        
        return memedImage
    }
    
    func updateFont(font: String) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: font, size: 40)!,
            NSStrokeWidthAttributeName : -1
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
    }
    
    func setInitialState() {
        resetTextFields()
        imageView.image = nil
        shareButton.enabled = false
    }
    
    func imageChosen(image: UIImage) {
        imageView.image = image
        shareButton.enabled = true
    }
    
    private func resetTextFields() {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    private func initTextField(textField: UITextField) {
        textField.textAlignment = .Center
        textField.delegate = self
    }
    
    private func hideNavbarAndToolbar() {
        if let delegate = delegate {
            delegate.hideUIElements()
        }
        toolbar.hidden = true
    }
    
    private func showNavbarAndToolbar() {
        if let delegate = delegate {
            delegate.showHiddenUIElements()
        }
        toolbar.hidden = false
    }
}
extension MemeEditorView: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}