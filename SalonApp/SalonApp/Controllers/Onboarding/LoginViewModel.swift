//
//  LoginViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 10.09.2023.
//

import Foundation

protocol LoginViewModelInterface {
    func viewDidLoad()
}

final class LoginViewModel {
    private weak var view : LoginViewInterface?
    init(view:LoginViewInterface){
        self.view = view
    }
}

extension LoginViewModel  : LoginViewModelInterface {
  
    func viewDidLoad() {
        view?.setBackgroundColor("backColor")
        view?.prepareNavigationBarCollor(colorText: "black")
    }
    
    
}
