//
//  ShadowViewStyleSheet.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit

public enum ShadowViewStyleSheet: String {
    
    case cardRect
    case cardRound
    case cardCornerRounded
    
    public func getStyle() -> ShadowStyle {
        switch self {
        case .cardRect:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 0
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: 2)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 5
            return shadowStyle
            
        case .cardRound:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 6
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: 3)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 5
            return shadowStyle
            
        case .cardCornerRounded:
            var shadowStyle = ShadowStyle()
            shadowStyle.borderRadius = 20
            shadowStyle.shadowOffsetStyle = CGSize(width: 0, height: 3)
            shadowStyle.shadowOpacityStyle = 0.2
            shadowStyle.shadowRadiusStyle = 19
            return shadowStyle
        }
    }
    
}
