//
//  UserModel.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import ObjectMapper

public class UserModel: Mappable, CustomStringConvertible {
    var username:       String!
    var email:          String!
    var password:       String!
    var sessionActive:  Bool!
    var idUser:         String!
    
    init() {
        self.username       = ""
        self.email          = ""
        self.password       = ""
        self.sessionActive  = false
        self.idUser         = self.setConsecutiveIdUser()
    }
    
    init(username: String, password: String, email: String, isActive: Bool) {
        self.username       = username
        self.email          = email
        self.password       = password
        self.sessionActive  = isActive
        self.idUser         = self.setConsecutiveIdUser()
    }
    
    required public init?(map: Map){}
    
    public func mapping(map: Map) {
        username        <- map["username"]
        email           <- map["email"]
        password        <- map["password"]
        sessionActive   <- map["sessionActive"]
        idUser          <- map["idUser"]
    }
    
    public func setConsecutiveIdUser() -> String {
        return String(format: self.username.trim(),"_\(DataSourceManager.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel).count + 1)")
    }
    
    public func getWelcomeText() -> String {
        return "Hello " + self.username
    }
    
    public var description: String {
        return "UserModel: {username: \(String(describing: username)), password: \(String(describing: password)), sessionActive: \(String(describing: sessionActive))}"
    }
}
