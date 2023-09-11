//
//  RegisterViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 10.09.2023.
//

import Foundation


protocol RegisterViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func didTapLogin()
    func createAccount(name:String,surname:String,email:String,password:String)
}

final class RegisterViewModel {
    private weak var view : RegisterViewInterface?
    
    init(view:RegisterViewInterface){
        self.view = view
    }
    
    func loginData(){
        // serviceConnect
    }
}

extension RegisterViewModel: RegisterViewModelInterface {
    func viewDidLoad() {
        view?.setBackgroundColor("backColor")
        view?.prepareNavigationBarCollor(colorText: "black")
        view?.prepareTabbarHidden(isHidden: true)
    }
    
    func viewWillAppear() {
        view?.prepareTabbarHidden(isHidden: true)
    }
    
    func didTapLogin() {
        let vc = LoginViewController()
        view?.pushViewControllerable(vc, identifier: "LoginViewControllerIdentifier")
    }
    
    
    func createAccount(name: String, surname: String, email: String, password: String) {
        var isNameAlertHidden: Bool = true
        var nameAlertMes: String = ""
        var isSurnameAlertHidden: Bool = true
        var surnameAlertMes: String = ""
        var isEmailAlertHidden: Bool = true
        var emailAlertMes: String = ""
        var isPasswordAlertHidden: Bool = true
        var passwordAlertMes: String = ""
        
        if name.count <= 3{
            isNameAlertHidden = false
            nameAlertMes = "Your name must be at least three letters"
        }
        
        else if surname.count <= 3 {
            isSurnameAlertHidden = false
            surnameAlertMes = "Your surnamename must be at least three letters"
        }
        
       else if !email.isValidEmail() {
            isEmailAlertHidden = false
            emailAlertMes = "Please enter a valid e-mail address"
            
        }
        
       else if password.count <= 10 {
            isPasswordAlertHidden = false
            passwordAlertMes = "Your password must be at least ten characters"
        }
        
        else {
            print("hesap oluşturma başarılı")
        }
        
        view?.alertMessage(isNameAlertHidden: isNameAlertHidden, nameAlertMes: nameAlertMes, isSurnameAlertHidden: isSurnameAlertHidden, surnameAlertMes: surnameAlertMes, isEmailAlertHidden: isEmailAlertHidden, emailAlertMes: emailAlertMes, isPasswordAlertHidden: isPasswordAlertHidden, passwordAlertMes: passwordAlertMes)
        
       

    }
    
    
    
}
