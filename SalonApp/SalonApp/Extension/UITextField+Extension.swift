//
//  UITextField+Extension.swift
//  SalonApp
//
//  Created by engin gülek on 11.09.2023.
//

import Foundation
import UIKit
extension UITextField {
    func leftUIView() -> UIView {
        let leftuiview = UIView()
        leftuiview.frame.size.width = 10
        return leftuiview
    }
    
    func texrFielLogin() {
    
        self.autocapitalizationType = .none
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
      
        self.leftViewMode = .always
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
