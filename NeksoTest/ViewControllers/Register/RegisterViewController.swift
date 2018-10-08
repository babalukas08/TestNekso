//
//  RegisterViewController.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 06/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: BaseViewController {

    @IBOutlet var txtFieldUsername: InputView!
    @IBOutlet var txtFieldEmail: InputView!
    @IBOutlet var txtFieldPass: InputView!
    @IBOutlet var btnCreateAccount: DefaultButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel: RegisterViewModel? {
        didSet {
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userModel = UserModel()
        self.viewModel = RegisterViewModel(userModel: userModel)
        self.manageKeyBoard = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.txtFieldUsername.text = ""
        self.txtFieldPass.text = ""
        self.txtFieldEmail.text = ""
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
            viewModel.txtUsername.value = self.txtFieldUsername.input.text ?? ""
        }).disposed(by: disposeBag)
        
        self.txtFieldEmail.input.rx.controlEvent(.editingDidEnd).subscribe(onNext:{ text in
            viewModel.txtEmail.value = self.txtFieldEmail.input.text ?? ""
        }).disposed(by: disposeBag)
        
        self.txtFieldPass.input.rx.controlEvent(.editingDidEnd).subscribe(onNext:{ text in
            viewModel.txtPass.value = self.txtFieldPass.input.text ?? ""
        }).disposed(by: disposeBag)
        
        self.btnCreateAccount.rx.tap.subscribe({ value in
            self.view.endEditing(true)
            viewModel.createAccountAction()
        }).disposed(by: disposeBag)

    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WelcomeViewController" {
            if let destination = segue.destination as? WelcomeViewController {
                if let idUser = sender as? String {
                    destination.idUserModel = idUser
                }
            }
        }
    }

}

extension RegisterViewController : RegisterViewModelDelegate {
    
    var txtUsername: DynamicViewModel<String> {
        return DynamicViewModel("\(self.txtFieldUsername.input.text ?? "")")
    }
    
    var txtEmail: DynamicViewModel<String> {
        return DynamicViewModel("\(self.txtFieldEmail.input.text ?? "")")
    }
    
    var txtPass: DynamicViewModel<String> {
        return DynamicViewModel("\(self.txtFieldEmail.input.text ?? "")")
    }
    
    func createAccountResult(result: ManagerResult, idUser: String?) {
        switch result {
        case .success:
            self.performSegue(withIdentifier: "WelcomeViewController", sender: idUser)
        case .failure(let message):
            self.showMessageDialog("Error", message: message, textButtonOne: "Ok", textButtonTwo: "")
        }
    }
}
