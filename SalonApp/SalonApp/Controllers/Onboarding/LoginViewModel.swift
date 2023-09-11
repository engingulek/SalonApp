//
//  LoginViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 10.09.2023.
//

import Foundation

protocol LoginViewModelInterface {
    func viewDidLoad()
    func controlEmail(email:String)
    func controlPassword(password:String)
    func login(email:String,password:String)

}

final class LoginViewModel {
    private weak var view : LoginViewInterface?
    private var loginButtonEnable : Bool = false
    private var emailData : String = ""
    private var passwordData : String = ""
    init(view:LoginViewInterface){
        self.view = view
    }
}

extension LoginViewModel  : LoginViewModelInterface {
    
    func controlEmail(email: String) {
        emailData = email
    }
    
    func controlPassword(password: String) {
       passwordData = password
    }
    
   
    
    func viewDidLoad() {
        view?.setBackgroundColor("backColor")
        view?.prepareNavigationBarCollor(colorText: "black")
    }
    
    func login(email name:String,password surname:String)  {
        if !emailData.isValidEmail() {
            view?.alertMessage(isHiddenEmailMes: false, isHiddenPassMes: true,
                               emailMes: "Please enter a valid e-mail address", pasmessage: "",
                               emailColor: "allServiceSelected", passcolor: "black")
            
        } else if emailData.isValidEmail() && passwordData.count < 8 {
            view?.alertMessage(isHiddenEmailMes: true, isHiddenPassMes: false,
                               emailMes: "", pasmessage: "Enter a password of at least 10 characters",
                               emailColor: "black", passcolor: "allServiceSelected")
        }else{
            view?.alertMessage(isHiddenEmailMes: true, isHiddenPassMes: true,
                               emailMes: "", pasmessage: "",
                               emailColor: "black", passcolor: "black")
        }
    }
    

  
    
    
}
