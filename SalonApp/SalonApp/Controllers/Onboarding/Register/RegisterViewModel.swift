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
    
    
}
