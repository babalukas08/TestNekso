//
//  Constants.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    
    struct GlobalMessage {
        struct Error {
            static let errorMessage = "Servicio no disponible"
            static let errorDetailProduct = "Producto no encontrado, intenta con otro"
        }
        
        struct Connection {
            static let internetConnection = "Se requiere conexión a Internet"
        }

    }
    
    struct colorsFe {
        static let colorFeGray = UIColor(hexString: "#708090")!
        static let colorFeLightSteelBlue = UIColor(hexString: "#B0C4DE")!
        static let backgroundColor = UIColor(hexString: "#002838")!
        static let backgroundColorBlackAlpha65 = UIColor(hexString: "#000000A6")!
        static let colorFeBlue = UIColor(hexString: "#2F87C6")!
        
        static let colorDefaultButton = UIColor(hexString: "#808080")!
        static let colorPrimaryButton = UIColor(hexString: "#3c8dbc")!
        static let colorSuccessButton = UIColor(hexString: "#00a65a")!
        static let colorInfoButton = UIColor(hexString: "#5bc0de")!
        static let colorWarningButton = UIColor(hexString: "#f39c12")!
        static let colorDangerButton = UIColor(hexString: "#dd4b39")!
        static let colorDeshabilitado = UIColor(hexString: "#d6d6d6")!
    }
    
    struct devicesSize {
        static let widthDeviceThird = UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3)
        static let widthDevice = UIScreen.main.bounds.width
        static let widthDeviceInsets = UIScreen.main.bounds.width - 30
        static let widthDeviceMiddle = (UIScreen.main.bounds.width/2)
        static let heightDevice = UIScreen.main.bounds.height
        static let widthTestSize = (UIScreen.main.bounds.width / 4)
    }
    
    struct KeysRealmObject {
        static let CacheManagerRealm = "CacheManager"
        static let RealmUserModel = "UsersModel"
    }

}

// MARK: Enums App
enum ManagerResult {
    case success
    case failure(message:String)
}

