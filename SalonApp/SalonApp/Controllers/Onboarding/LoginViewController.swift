//
//  LoginViewController.swift
//  SalonApp
//
//  Created by engin gülek on 29.07.2023.
//

import UIKit
import SnapKit

protocol LoginViewInterface : AnyObject,ViewAble,NavigaitonBarAble {
 
}

final class LoginViewController: UIViewController {
    private lazy var viewModel = LoginViewModel(view: self)
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return textField
    }()
    
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
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
        configureConstraints()
    }
    
    
    private func configureConstraints() {
        view.addSubview(loginTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
       
        loginTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(loginTitleLabel.snp.bottom).offset(20)
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
        
        loginButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
    }
}

extension LoginViewController : LoginViewInterface {
    
}
