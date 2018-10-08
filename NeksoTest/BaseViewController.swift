//
//  BaseViewController.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 06/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var manageKeyBoard = false
    var viewTapRecognizer: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if manageKeyBoard {
            registerKeyBoardNotification()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if manageKeyBoard {
            deRegisterKeyBoardNotification()
        }
    }
    
    // MARK: - Keyboard
    func registerKeyBoardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deRegisterKeyBoardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ aNotification:Notification) {
        
        if let viewTapRecognizer = self.viewTapRecognizer {
            self.view.removeGestureRecognizer(viewTapRecognizer)
            self.viewTapRecognizer = nil
        }
        
        self.viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        if let viewTapRecognizer = self.viewTapRecognizer {
            self.view.addGestureRecognizer(viewTapRecognizer)
        }
        
    }
    
    @objc func keyboardWillHide(_ aNotification:Notification) {
        if let viewTapRecognizer = self.viewTapRecognizer {
            self.view.removeGestureRecognizer(viewTapRecognizer)
            self.viewTapRecognizer = nil
        }
    }
    
    @objc func onTapView() {
        self.view.endEditing(true)
    }
    
    // MARK: Show Dialogs
    func showMessageDialog(_ title: String, message: String, textButtonOne: String, textButtonTwo: String, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertViewController.addAction(UIAlertAction(title: textButtonOne, style: UIAlertActionStyle.default, handler: okHandler))
        if cancelHandler != nil {
            alertViewController.addAction(UIAlertAction(title: textButtonTwo, style: UIAlertActionStyle.default, handler: cancelHandler))
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UINavigationBar

extension UINavigationBar {
    
    func setStyle() {
        
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = .clear
        
        self.barTintColor = ColorPallete.white.asColor(withAlpha: 0.30)
        self.backItem?.prompt = ""
        self.tintColor = ColorPallete.white.asColor()
        let attrs = [
            NSAttributedStringKey.foregroundColor : ColorPallete.white.asColor()
        ]
        self.titleTextAttributes = attrs
        
    }
}
