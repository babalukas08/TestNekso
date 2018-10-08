//
//  Sizes.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//


import Foundation
import UIKit

public enum SizesPallete {
    
    public enum TextSize: Int {
        case textBase12 = 12
        case txtBase15  = 15
        case text17     = 17
    }
    
    public enum IconSize {
        case verySmall
        case medium
        
        public func getSize() -> CGSize {
            switch self {
            case .verySmall:
                return CGSize(width: 20, height: 20)
            default:
                return CGSize(width: 20, height: 20)
            }
        }
    }
    
    public enum ButtonSize: Int {
        case btnPrimary = 48
        case btnSecondary = 40
        case horizontaInset = 24
        case searchButton = 19
    }
    
}

