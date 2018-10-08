//
//  Typography.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//


import UIKit

public enum TypographyStyle: String {
    //
    case txtHeaderGeneral
    case txtHeaderGeneralBlack
    case txtDateAlertIndicator
    case txtHelvetica15Black
    case txtHeaderGeneralPink
    case txtHeaderGeneralGreen
    
    
    public func getStyle() -> TextStyle {
        switch self {
        case .txtHeaderGeneralGreen:
            let color = ColorPallete.neksoGreen.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .txtHeaderGeneralPink:
            let color = ColorPallete.neksoPink.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .txtHeaderGeneral:
            let color = ColorPallete.white.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .txtHeaderGeneralBlack:
            let color = ColorPallete.black.asColor()
            let size = SizesPallete.TextSize.text17.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        case .txtHelvetica15Black:
            let color = ColorPallete.black.asColor()
            let size = SizesPallete.TextSize.txtBase15.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
        case .txtDateAlertIndicator:
            let color = ColorPallete.warmGrey.asColor()
            let size = SizesPallete.TextSize.textBase12.rawValue
            let font = FontPallete.sanFrancisco.asFont(ofSize: CGFloat(size))
            
            var textStyle = TextStyle()
            textStyle.color = color
            textStyle.size = size
            textStyle.font = font
            return textStyle
            
        }
    }
}
