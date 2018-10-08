//
//  NeksoTestTests.swift
//  NeksoTestTests
//
//  Created by Mauricio Jimenez on 05/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import XCTest
import ObjectMapper
import RxSwift
import RxTest
import RxBlocking

@testable import NeksoTest

class NeksoTestTests: XCTestCase {

    static let TIMEOUT: Double = 15.0
    var registerModel: RegisterViewModel?
    let registerSuccessRequestModel = UserModel(username: "mauricio87", password: "p455w0rd", email: "mauricio87@gmail.com", isActive: false)
    let registerFailureRequestModel = UserModel(username: "", password: "", email: "mauricio87@gmail.com", isActive: false)
    
    var userModelTest = UserModel()
    let loginFailureRequestModel = LoginRequest(user: "dummy", pass: "wrongPass")
    let userResetFailureEmail = "wrongUser@neckso.com"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        DataSourceManager.deleteUserByModel(userModel: self.userModelTest) { (result) in
            print("Delete UsersTest")
        }
    }
    
    // MARK - Register Tests
    
    func testRegisterFailure() {
        self.registerModel = RegisterViewModel(userModel: self.registerFailureRequestModel)
        
        guard let register = self.registerModel else {
            XCTFail("Couldn't load auth register model")
            return
        }
        
        self.createAccountAction(registerModel: register) { (result) in
            switch result {
            case .failure(let message):
                XCTAssert(true, message)
            case .success:
                XCTAssert(false, "Successful registration")
            }
        }
    }
    
    func testRegisterAndLoginSuccess() {
        self.userModelTest = registerSuccessRequestModel
        self.registerModel = RegisterViewModel(userModel: userModelTest)
        
        guard let register = self.registerModel else {
            XCTFail("Couldn't load auth register model")
            return
        }
        
        self.createAccountAction(registerModel: register) { (result) in
            switch result {
            case .failure(let message):
                XCTAssert(false, message)
            case .success:
                self.testLoginSuccess()
            }
        }
    }
    
    // MARK: - Login Tests
    func testLoginSuccess() {
        self.userModelTest = registerSuccessRequestModel
        let login = LoginViewModel(txtUsernameOrEmail: self.userModelTest.username, txtPass: self.userModelTest.password)
        
        self.loginAction(loginModel: login) { (result) in
            switch result {
            case .failure(let message):
                XCTAssert(false, message)
            case .success:
                XCTAssert(true, "Successful Login")
            }
        }
    }
    
    // MARK - Utils
    func createAccountAction(registerModel: RegisterViewModel, completion: @escaping (_ result: ManagerResult) -> Void) {
        
        if registerModel.txtUsername.value.isEmpty {
            completion(.failure(message: "Please enter a username"))
        }
        else if registerModel.txtEmail.value.isEmpty || !registerModel.txtEmail.value.isEmail {
            completion(.failure(message: "Please enter a valid email"))
        }
        else if registerModel.txtPass.value.isEmpty {
            completion(.failure(message: "Please enter a password"))
        }
        else {
            let userModel = UserModel(username: registerModel.txtUsername.value, password: registerModel.txtPass.value, email: registerModel.txtEmail.value, isActive: false)
            
            
            DataSourceManager.addUpdateUserByModel(userModel: userModel) { (result) in
                completion(.success)
            }
        }
    }
    
    func loginAction(loginModel: LoginViewModel, completion: @escaping (_ result: ManagerResult) -> Void) {
        
        if loginModel.txtUsernameOrEmail.value.isEmpty {
            completion(.failure(message: "Please enter a username"))
        }
        else if loginModel.txtPass.value.isEmpty {
            completion(.failure(message: "Please enter a password"))
        }
        else {
            let loginModel = LoginRequest(user: loginModel.txtUsernameOrEmail.value, pass: loginModel.txtPass.value)
            
            if let _ = DataSourceManager.getUserByLoginRequest(loginModel: loginModel) {
                completion(.success)
            }
            else {
                completion(.failure(message: "incorrect username and/or password \n please verify your information"))
            }
        }
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
