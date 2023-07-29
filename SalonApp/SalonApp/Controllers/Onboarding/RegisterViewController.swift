//
//  RegisterViewController.swift
//  SalonApp
//
//  Created by engin gülek on 29.07.2023.
//

import UIKit
import SnapKit
class RegisterViewController: UIViewController {
    
    private let registerTitleLabel: UILabel = {
          let label = UILabel()
          
          label.text = "Create your account"
          label.font = .systemFont(ofSize: 32, weight: .bold)
          return label
      }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return textField
    }()
    
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Create account", for: .normal)
         button.tintColor = .white
         button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
         button.backgroundColor = UIColor(named: "allServiceSelected")
         button.layer.masksToBounds = true
         button.layer.cornerRadius = 25
         button.isEnabled = false
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(named: "backColor")
        view.addSubview(registerTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        configureConstraints()
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    private func configureConstraints() {
        registerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(registerTitleLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
    }


}
