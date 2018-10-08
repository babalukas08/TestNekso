//
//  FloatLabelStyleSheet.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit

public enum FloatLabelStyleSheet: String {
    
    case white
    case grey
    
    public func getStyle() -> FloatLabelStyle {
        switch self {
        case .white:
            var floatLabelStyle = FloatLabelStyle()
            floatLabelStyle.floatTextStyle = TypographyStyle.txtHelvetica15Black.getStyle()
            floatLabelStyle.textStyle = TypographyStyle.txtDateAlertIndicator.getStyle()
            floatLabelStyle.placeHolderStyle = TypographyStyle.txtDateAlertIndicator.getStyle()
            
            floatLabelStyle.clearFieldImage = UIImage(named: "ndIc24White")
            
            floatLabelStyle.badFieldImage = UIImage(named: "")
            
            floatLabelStyle.goodFieldImage = UIImage(named: "ndIc32OkGreen")
            
            floatLabelStyle.bottomLineColor = ColorPallete.white.asColor(withAlpha: 0.75)
            floatLabelStyle.bottomLineHeight = 1
            
            return floatLabelStyle
            
        case .grey:
            var floatLabelStyle = FloatLabelStyle()
            floatLabelStyle.floatTextStyle = TypographyStyle.txtDateAlertIndicator.getStyle()
            floatLabelStyle.textStyle = TypographyStyle.txtHelvetica15Black.getStyle()
            floatLabelStyle.placeHolderStyle = TypographyStyle.txtHelvetica15Black.getStyle()
            
            floatLabelStyle.clearFieldImage = UIImage(named: "ndIc24Clear600")
            
            floatLabelStyle.badFieldImage = UIImage(named: "")
            
            floatLabelStyle.goodFieldImage = UIImage(named: "ndIc32OkGreen")
            
            floatLabelStyle.bottomLineColor = ColorPallete.black.asColor()
            floatLabelStyle.bottomLineHeight = 1
            
            return floatLabelStyle
        }
    }
    
}

