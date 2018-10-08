//
//  ButtonStyleSheet.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//


import UIKit

public enum ButtonStyleSheet: String {
    
    case btn_default = "btn-default"
    case transparentWhite
    case roundButton
    
    public func getStyle() -> ButtonStyle {
        var buttonStyle = ButtonStyle()
        buttonStyle.primaryTextStyle = TypographyStyle.txtHeaderGeneralBlack.getStyle()
        buttonStyle.secondaryTextStyle = TypographyStyle.txtHeaderGeneralBlack.getStyle()
        buttonStyle.leftInset = SizesPallete.ButtonSize.horizontaInset.rawValue
        buttonStyle.rightInset = SizesPallete.ButtonSize.horizontaInset.rawValue
        
        switch self {
        case .roundButton:
            buttonStyle.primaryViewStyle = ViewStyleSheet.transparent.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.transparent.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
        case .transparentWhite:
            buttonStyle.primaryViewStyle = ViewStyleSheet.transparent.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.transparent.getStyle()
            buttonStyle.primaryTextStyle = TypographyStyle.txtHeaderGeneralBlack.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHeaderGeneralBlack.getStyle()
            buttonStyle.leftInset = 0
            buttonStyle.rightInset = 0
            
        case .btn_default:
            buttonStyle.primaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
            buttonStyle.secondaryTextStyle = TypographyStyle.txtHeaderGeneral.getStyle()
            buttonStyle.primaryViewStyle = ViewStyleSheet.btn_default.getStyle()
            buttonStyle.secondaryViewStyle = ViewStyleSheet.btn_default.getStyle()
            buttonStyle.leftInset = 15
            buttonStyle.rightInset = 15
        }
        
        return buttonStyle
    }
}

