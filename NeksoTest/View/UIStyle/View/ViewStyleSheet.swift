//
//  ViewStyleSheet.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit

public enum ViewStyleSheet: String {
    
    // base Views
    case transparent
    case rounded
    case roundCorners
    case pinkOpacity
    case whiteOpacity
    case whiteOpacityLeft
    case whiteOpacityRight
    // Styles for Alerts Message
    case isEnabledView
    // Styles buttons
    case btn_default
    case greenButton
    case whiteBorders

    
    
    public func getStyle() -> ViewStyle {
        switch self {
        case .transparent:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = UIColor.clear
            return viewStyle
        case .rounded:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.round
            return viewStyle
        case .roundCorners:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.black.asColor(withAlpha: 0.70)
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.cornerRadiusStyle = 20
            return viewStyle
        case .pinkOpacity:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.neksoPink.asColor(withAlpha: 0.40)
            viewStyle.shape = ViewStyle.ViewShape.rect
            return viewStyle
        case .whiteOpacity:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.white.asColor(withAlpha: 0.60)
            viewStyle.shape = ViewStyle.ViewShape.rect
            return viewStyle
        case .whiteOpacityLeft:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.white.asColor(withAlpha: 0.60)
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.cornersBy = .left
            viewStyle.cornerRadiusStyle = 5
            return viewStyle
        case .whiteOpacityRight:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.white.asColor(withAlpha: 0.60)
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.cornersBy = .right
            viewStyle.cornerRadiusStyle = 5
            return viewStyle
        case .isEnabledView:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = ColorPallete.warmGrey.asColor(withAlpha: 0.70)
            return viewStyle
            // Buttons
        case .greenButton:
            var viewStyle = ViewStyle()
            viewStyle.backgroundColor = ColorPallete.greenButton.asColor()
            viewStyle.shape = ViewStyle.ViewShape.round
            return viewStyle

        case .btn_default:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = .clear
            viewStyle.cornerRadiusStyle = 5
            viewStyle.borderColor = ColorPallete.white.asColor()
            viewStyle.borderWidth = 5
            return viewStyle
        case .whiteBorders:
            var viewStyle = ViewStyle()
            viewStyle.shape = ViewStyle.ViewShape.rect
            viewStyle.backgroundColor = .clear
            viewStyle.cornerRadiusStyle = 6
            viewStyle.borderColor = ColorPallete.white.asColor()
            viewStyle.borderWidth = 1
            return viewStyle
        }
    }
}
