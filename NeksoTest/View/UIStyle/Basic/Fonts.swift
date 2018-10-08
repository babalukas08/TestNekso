//
//  Fonts.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//


import Foundation
import UIKit


public enum FontWeight {
    case light
    case base
    case bold
    case semibold
    case medium
}

public enum FontPallete {
    
    case sanFrancisco
    
    public func asFont(ofSize: CGFloat) -> UIFont {
        let font = UIFont.systemFont(ofSize: CGFloat(ofSize))
        return font
    }
    
    public func asFont(ofSize: CGFloat, withWeight weight: FontWeight) -> UIFont {
        switch weight {
        case .light:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .light)
        case .base:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .regular)
        case .medium:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .medium)
        case .bold:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .bold)
        case .semibold:
            return UIFont.systemFont(ofSize: CGFloat(ofSize), weight: .semibold)
        }
    }
    
}

