//
//  InputView.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 06/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

struct InputViewModel  {
    public var placeHolder: String?
    public var typeInput: TypeInputView?
    public init() { }
}

@IBDesignable
class InputView: NibDesignable {
    
    @IBOutlet var rootView: StylableView!
    @IBOutlet weak var imageView: StylableImageView!
    @IBOutlet weak var input: StylableTextField!
    
    
    var index = 0
    let disposeBag = DisposeBag()
    
    
    @IBInspectable public var text: String = "" {
        didSet {
            self.input.text = text
        }
    }
    
    @IBInspectable public var placeholder: String = "" {
        didSet {
            self.input.placeholder = placeholder
        }
    }
    
    @IBInspectable public var typeInput: String = "ico_user" {
        didSet {
            self.configureTypeInput(type: typeInput)
        }
    }
    
    @IBInspectable public var imagefromAssets: String = "" {
        didSet {
            if !imagefromAssets.isEmpty {
                self.imageView.image = UIImage(named: imagefromAssets)
                self.imageView.adjustImage()
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Config View
    func setupView() {
        
    }
    
    func configure(modelGeneric: InputViewModel) {

        guard let type = modelGeneric.typeInput else {
            return
        }
        
        self.configureTypeInput(type: type.rawValue)
    }
    
    func configureTypeInput(type: String) {
        switch type {
        case TypeInputView.username.rawValue:
            self.imagefromAssets = "ico_user"
        case TypeInputView.email.rawValue:
            self.imagefromAssets = "ico_mail"
            self.input.keyboardType = .emailAddress
        case TypeInputView.pass.rawValue:
            self.imagefromAssets = "ico_password"
            self.input.isSecureTextEntry = true
        default:
            break
        }
    }
}

enum TypeInputView : String {
    case username
    case email
    case pass
}
