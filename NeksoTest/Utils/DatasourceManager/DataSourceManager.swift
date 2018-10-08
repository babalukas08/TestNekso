//
//  DataSourceManager.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

final class DataSourceManager {

    // MARK: -  methods for Realm DataSource
    
    // Get all User's from device DB
    static func getUserFromDB(modelRealm: String) -> [UserModel] {
        if let stateCache = self.requestDataFromCache(realName: Constants.KeysRealmObject.CacheManagerRealm, cacheManagerName: modelRealm) {
            if let resp : [UserModel] = Mapper<UserModel>().mapArray(JSONString: stateCache)  {
                return resp
            }
        }
        return []
    }
    
    // Get User by Id
    static func getUserById(idUser: String) -> UserModel? {
        let allLetters = self.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel)
        let userModel = allLetters.first { (user) -> Bool in
            user.idUser == idUser
        }
        return userModel
    }
    
    // Get User by LoginRequestModel
    static func getUserByLoginRequest(loginModel: LoginRequest) -> UserModel? {
        let allLetters = self.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel)
        let userModel = allLetters.first { (user) -> Bool in
            user.password == loginModel.pass &&
            (user.username == loginModel.userOrEmail || user.email == loginModel.userOrEmail)
        }
        return userModel
    }
    
    // Add or update by UserModel
    static func addUpdateUserByModel(userModel : UserModel, completion: @escaping (_ result: ManagerResult) -> Void) {
        var allUsers = self.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel)
        
        if let indexEqual = self.getIndexbyModel(userModel: userModel)  {
            userModel.sessionActive = true
            allUsers[indexEqual] = userModel
        }
        else {
            userModel.sessionActive = true
            allUsers.append(userModel)
        }
        
        // this line is for update the userMode on Realm
        completion(self.saveCacheModel(Constants.KeysRealmObject.RealmUserModel, value: allUsers.toJSONString() ?? ""))
    }
    
    // Delete User by UserModel
    static func deleteUserByModel(userModel : UserModel, completion: @escaping (_ result: ManagerResult) -> Void) {
        var allUsers = self.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel)
        
        guard let indexEqual = self.getIndexbyModel(userModel: userModel) else {
            completion(.failure(message: "Error indice"))
            return
        }
        
        allUsers.remove(at: indexEqual)
        
        // this line is for update the userMode on Realm
        completion(self.saveCacheModel(Constants.KeysRealmObject.RealmUserModel, value: allUsers.toJSONString() ?? ""))
    }
    
    // Delete All users
    static func deleteUserByModel(completion: @escaping (_ result: ManagerResult) -> Void) {
        var allUsers = self.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel)

        allUsers.removeAll()
        
        // this line is for update the userMode on Realm
        completion(self.saveCacheModel(Constants.KeysRealmObject.RealmUserModel, value: allUsers.toJSONString() ?? ""))
    }
    
    // Get index UserModel
    static func getIndexbyModel(userModel: UserModel) -> Int? {
        let allUsers = self.getUserFromDB(modelRealm: Constants.KeysRealmObject.RealmUserModel)
        
        guard let index = allUsers.index(where: { (item) -> Bool in
            item.idUser == userModel.idUser
        }) else {
            return nil
        }
        
        return index
    }
    
    // Get String model of Realm
    static func requestDataFromCache(realName: String, cacheManagerName: String) -> String? {
        var stringValue: String?
        print("Reading Data from cache")
        
        if let cacheManager = try? RealmCacheManager(realmName: realName) {
            if let cacheObject = cacheManager.get(cacheManagerName) {
                stringValue = cacheObject.value
            }
        }
        else {
            print("Data NOT read")
        }
        
        return stringValue
    }
    
    // Save String model of Realm
    static func saveCacheModel(_ urlString: String, value: String) -> ManagerResult {
        print("Saving CacheModel to cache")
        if let cacheManager = try? RealmCacheManager(realmName: Constants.KeysRealmObject.CacheManagerRealm) {
            cacheManager.add(urlString, value: value)
            print("CacheModel saved to cache successfully")
            return .success
        }
        else {
            print("CacheModel NOT saved")
            return .failure(message: "Error al guardar Dato en DB")
        }
    }
    
    // MARK: -  Methods for validations DataSource

}
