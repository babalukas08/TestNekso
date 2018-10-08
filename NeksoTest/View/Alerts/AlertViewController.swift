//
//  AlertViewController.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit

public protocol AlertController {

    func showInputAlert(modelProgressAlertViewModel: InfoMapViewModel) -> InfoMapView
//    func showGenericSKuAlert(modelProgressAlertViewModel: GenericSkuModalViewModel, delegate: GenericSkuModalViewDelegate) -> GenericSkuModalView
//    //GenericSkuModalView

}
// InfoMapView
public extension AlertController where Self: UIViewController {
    
    @discardableResult func showInputAlert(modelProgressAlertViewModel: InfoMapViewModel) -> InfoMapView {
        let modAlertSingleButton = InfoMapView()
        modAlertSingleButton.configure(modelGeneric: modelProgressAlertViewModel)
        modAlertSingleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let hostViewController = AlertHostController()
        hostViewController.view.addSubview(modAlertSingleButton)
        
        let sizeModal = CGSize(width: Constants.devicesSize.widthDevice - 50, height: 200)
        
        setConstraintsForAlert(alert: modAlertSingleButton, containerView: hostViewController.view, size: sizeModal)
        self.present(hostViewController, animated: true, completion: nil)
        
        return modAlertSingleButton

    }
    
    func setConstraints(alert: UIView, containerView: UIView, size: CGSize? = nil, isTop: Bool? = nil) {
        alert.translatesAutoresizingMaskIntoConstraints = false
        
        
        let centerConstraintX = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: containerView,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintTop = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: containerView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintBottom = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: containerView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 0)
        
        containerView.addConstraints([centerConstraintX, centerConstraintTop, centerConstraintBottom])
        alert.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 89).isActive = true
        alert.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        alert.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 7).isActive = true
        alert.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 250).isActive = true
        
        
    }
    func setConstraintsForAlert(alert: UIView, containerView: UIView, size: CGSize? = nil, isTop: Bool? = nil) {
        
        let width : CGFloat = size != nil ? size!.width : Constants.devicesSize.widthDevice - 44
        let height: CGFloat = size != nil ? size!.height : 350
        
        
        let widthConstraint = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: width)
        
        let heightConstraint = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: height)
        
        let centerConstraintX = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: containerView,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintY = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: containerView,
            attribute: NSLayoutAttribute.centerY,
            multiplier: 1,
            constant: 0)
        
        let centerConstraintTop = NSLayoutConstraint(
            item: alert,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: containerView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 20)
        
        alert.addConstraint(widthConstraint)
        alert.addConstraint(heightConstraint)
        
        if let top = isTop {
            if !top {
                containerView.addConstraints([centerConstraintX, centerConstraintY])
            }
            else {
                containerView.addConstraints([centerConstraintX, centerConstraintTop])

            }
        }
        else {
            containerView.addConstraints([centerConstraintX, centerConstraintY])
        }
    }
    
}

class AlertHostController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIView()
        backgroundView.frame = self.view.bounds
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(backgroundView)
        
        self.view.backgroundColor = ColorPallete.gray900.asColor(withAlpha: 0.5)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBackground))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onTapBackground() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
