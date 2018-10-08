//
//  RegisterViewModel.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 08/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelDelegate : class {
    var txtUsername: DynamicViewModel<String> { get }
    var txtEmail: DynamicViewModel<String> { get }
    var txtPass: DynamicViewModel<String> { get }
    
    func createAccountResult(result: ManagerResult, idUser: String?)
}

class RegisterViewModel {
    weak var delegate: RegisterViewModelDelegate?
    
    let txtUsername: DynamicViewModel<String>
    let txtEmail: DynamicViewModel<String>
    let txtPass: DynamicViewModel<String>
    
    init(userModel: UserModel) {
        self.txtUsername = DynamicViewModel("\(userModel.username ?? "")")
        self.txtEmail = DynamicViewModel("\(userModel.email ?? "")")
        self.txtPass = DynamicViewModel("\(userModel.password ?? "")")
    }
    
    func createAccountAction() {
        
        if self.txtUsername.value.isEmpty {
            self.delegate?.createAccountResult(result: .failure(message: "Please enter a username"), idUser: nil)
        }
        else if self.txtEmail.value.isEmpty || !self.txtEmail.value.isEmail {
            self.delegate?.createAccountResult(result: .failure(message: "Please enter a valid email"), idUser: nil)
        }
        else if self.txtPass.value.isEmpty {
            self.delegate?.createAccountResult(result: .failure(message: "Please enter a password"), idUser: nil)
        }
        
        
        let userModel = UserModel(username: self.txtUsername.value, password: self.txtPass.value, email: self.txtEmail.value, isActive: false)
        
        
        print("\n\n idUser: \(userModel.idUser ?? "" )txtUsername:\(txtUsername.value)\ntxtEmail.value: \(txtEmail.value)\ntxtPass.value : \(txtPass.value )")
        
        DataSourceManager.addUpdateUserByModel(userModel: userModel) { (result) in
            self.delegate?.createAccountResult(result: .success, idUser: userModel.idUser)
        }
        
    }
    
}
