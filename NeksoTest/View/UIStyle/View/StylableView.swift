//
//  StylableView.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit

@IBDesignable
public class StylableView: UIView, ViewStylable {
    
    public var borderLayer: CAShapeLayer = CAShapeLayer()
    
    @IBInspectable public var borderWidth: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var styleName: String? {
        didSet {
            styleNameDidSet()
        }
    }
    
    @IBInspectable public var viewShapeName: String? {
        didSet {
            viewShapeNameDidSet()
        }
    }
    
    public var viewShape: ViewStyle.ViewShape? = .rect {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var viewCorners: ViewStyle.ViewCorners? {
        didSet {
            if viewCorners != nil {
                setNeedsLayout()
            }
        }
    }
    
    public var viewStyle: ViewStyle? {
        didSet {
            applyStyle()
        }
    }
    
    @IBInspectable public var cornerRadiusStyle: Int = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    public func applyStyle() {
        applyBasicViewStyle()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        resizeBorderAndMaskLayer()
        if self.viewCorners != nil {
            resizeCornersBySide()
        }
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setNeedsLayout()
    }
    
}
