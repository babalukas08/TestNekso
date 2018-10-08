//
//  LoginViewModel.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 08/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModelDelegate : class {
    var txtUsernameOrEmail: DynamicViewModel<String> { get }
    var txtPass: DynamicViewModel<String> { get }
    
    func loginResult(result: ManagerResult, userModel: UserModel?)
}


class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    
    let txtUsernameOrEmail: DynamicViewModel<String>
    let txtPass: DynamicViewModel<String>
    
    init(txtUsernameOrEmail: String, txtPass: String) {
        self.txtUsernameOrEmail = DynamicViewModel("\(txtUsernameOrEmail)")
        self.txtPass = DynamicViewModel("\(txtPass)")
    }
    
    func loginAction() {
        
        if self.txtUsernameOrEmail.value.isEmpty {
            self.delegate?.loginResult(result: .failure(message: "Please enter a username"), userModel: nil)
        }
            
        else if self.txtPass.value.isEmpty {
            self.delegate?.loginResult(result: .failure(message: "Please enter a password"), userModel: nil)
        }
        
        
        let loginModel = LoginRequest(user: self.txtUsernameOrEmail.value, pass: self.txtPass.value)
        
        if let user = DataSourceManager.getUserByLoginRequest(loginModel: loginModel) {
            self.delegate?.loginResult(result: .success, userModel: user)
        }
        else {
            self.delegate?.loginResult(result: .failure(message: "incorrect username and/or password \n please verify your information"), userModel: nil)
        }
    }
}

public struct LoginRequest {
    var userOrEmail = ""
    var pass = ""
    
    init(user: String, pass: String) {
        self.userOrEmail = user
        self.pass = pass
    }
}
