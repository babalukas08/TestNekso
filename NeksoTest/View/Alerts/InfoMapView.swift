//
//  InfoMapView.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 08/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//
// InfoMapView
import UIKit
import MapKit

public struct InfoMapViewModel  {
    public var userModel: UserModel?
    public var location: String?
    public init(userModel: UserModel, location: String) {
        self.userModel = userModel
        self.location = location
    }
}

@IBDesignable
public class InfoMapView: NibDesignable {
    
    @IBOutlet var rootView: StylableView!
    @IBOutlet weak var lbUsername: Heading!
    @IBOutlet weak var lbLocation: Heading!
    
    @IBInspectable public var username: String = "" {
        didSet {
            self.lbUsername.text = username
        }
    }
    
    @IBInspectable public var location: String = "" {
        didSet {
            self.lbLocation.text = location
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
    
    func configure(modelGeneric: InfoMapViewModel) {
        
        guard let user = modelGeneric.userModel else {
            return
        }
        
        self.username = user.getWelcomeText()
        self.location = modelGeneric.location ?? ""
        
    }
    
}

