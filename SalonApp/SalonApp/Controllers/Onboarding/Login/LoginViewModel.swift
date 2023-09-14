//
//  LoginViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 10.09.2023.
//

import Foundation
import UIKit.UIApplication

protocol LoginViewModelInterface {
    func viewDidLoad()
    func login(email:String,password:String)

}
private let appDelegate = UIApplication.shared.delegate as! AppDelegate
final class LoginViewModel {
    private weak var view : LoginViewInterface?
    private let serviceManager : LoginServiceInterface
   
    let context = appDelegate.persistentContainer.viewContext
   
  
    init(view:LoginViewInterface,serviceManager : LoginServiceInterface = LoginService.shared){
        self.view = view
        self.serviceManager = serviceManager
    }
    
    func loginUser(email:String,password:String) {
        let parameters = ["email" : email,"password":password]
        print(parameters)
        serviceManager.loginUser(parameters:parameters) { response in
            switch response {
            case .success(let success):
                if success.success{
                    if let user = success.data {
                        let userSave =  UserInfo(context: self.context)
                        userSave.id = Int16(user.id)
                        userSave.name = user.name
                        userSave.surname = user.surname
                        userSave.email =  user.email
                        userSave.imageurl = user.imageUrl
                        appDelegate.saveContext()
                    }
                    self.view?.navigationPopViewController()
                    self.view?.navigationPopViewController()
                    self.view?.tabbarSelectedIndex(at: 0)
                    
                    self.view?.singError(isHidden: true, message: "")
                }else{
                    self.view?.singError(isHidden: false, message: "Email or password is incorrect")
                 
                }
            case .failure(let failure):
                print("Sing error \(failure.localizedDescription)")
                self.view?.singError(isHidden: true, message: failure.localizedDescription)
            
                
            }
        }
    }
}

extension LoginViewModel  : LoginViewModelInterface {
    
 
   
    
    func viewDidLoad() {
        view?.setBackgroundColor("backColor")
        view?.prepareNavigationBarCollor(colorText: "black")
        view?.singError(isHidden: true, message: "")
    }
    
    func login(email:String,password:String)  {
        var  isHiddenEmailMes:Bool = true
        var  isHiddenPassMes:Bool =  true
        var  emailMes: String = ""
        var  pasmessage:String = ""
   
        
        if !email.isValidEmail() {
            isHiddenEmailMes = false
            emailMes = "Please enter a valid e-mail address"
        } else if email.isValidEmail() && password.count < 8 {
            isHiddenPassMes = false
            pasmessage = "Enter a password of at least 10 characters"
        }else{
            loginUser(email: email, password: password)
        }
        
        view?.alertMessage(isHiddenEmailMes: isHiddenEmailMes,
                           isHiddenPassMes: isHiddenPassMes,
                           emailMes: emailMes,
                           pasmessage: pasmessage)
    }
    

  
    
    
}
