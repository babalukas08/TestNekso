//
//  LoginViewController.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 06/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    @IBOutlet var txtFieldUsername: InputView!
    @IBOutlet var txtFieldPass: InputView!
    @IBOutlet var btnLogin: DefaultButton!
    @IBOutlet var btnCreateAccount: DefaultButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel: LoginViewModel? {
        didSet {
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginViewModel(txtUsernameOrEmail: "", txtPass: "")
        self.manageKeyBoard = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.txtFieldUsername.text = ""
        self.txtFieldPass.text = ""
    }
    
    fileprivate func fillUI() {
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.delegate = self
        
        // we are sure here that we have all the setup done
        self.txtFieldUsername.input.rx.controlEvent(.editingDidEnd).subscribe(onNext:{ text in
            viewModel.txtUsernameOrEmail.value = self.txtFieldUsername.input.text ?? ""
        }).disposed(by: disposeBag)
        
        self.txtFieldPass.input.rx.controlEvent(.editingDidEnd).subscribe(onNext:{ text in
            viewModel.txtPass.value = self.txtFieldPass.input.text ?? ""
        }).disposed(by: disposeBag)
        
        self.btnLogin.rx.tap.subscribe({ value in
            self.view.endEditing(true)
            viewModel.loginAction()
        }).disposed(by: disposeBag)
        
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SuccessLogin" {
            if let destination = segue.destination as? WelcomeViewController {
                if let idUser = sender as? String {
                    destination.idUserModel = idUser
                }
            }
        }
    }

}

extension LoginViewController : LoginViewModelDelegate {
    var txtUsernameOrEmail: DynamicViewModel<String> {
        return DynamicViewModel("\(self.txtFieldUsername.input.text ?? "")")

    }
    

    var txtPass: DynamicViewModel<String> {
        return DynamicViewModel("\(self.txtFieldPass.input.text ?? "")")
    }
    
    func loginResult(result: ManagerResult, userModel: UserModel?) {
        switch result {
        case .success:
            self.performSegue(withIdentifier: "SuccessLogin", sender: userModel?.idUser)
        case .failure(let message):
            self.showMessageDialog("Error", message: message, textButtonOne: "Ok", textButtonTwo: "")
        }
    }
    
}
