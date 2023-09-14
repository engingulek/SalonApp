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
    
    func addBorder(_ width : Double){
        let height = self.frame.size.height - 1
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: height , width: width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}


