//
//  View+Extension.swift
//  SalonApp
//
//  Created by engin gülek on 8.08.2023.
//

import Foundation
import UIKit.UITextField


extension UITextField {
    func addBorder(_ width : Double){
        let height = self.frame.size.height - 1
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: height , width: width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
}
