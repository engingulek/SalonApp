//
//  RegisterViewController.swift
//  SalonApp
//
//  Created by engin gülek on 29.07.2023.
//

import UIKit
import SnapKit

protocol RegisterViewInterface : AnyObject,ViewAble,SeguePerformable,NavigaitonBarAble {
    func prepareTabbarHidden(isHidden:Bool)
}

final class RegisterViewController: UIViewController {
    private lazy var viewModel = RegisterViewModel(view: self)
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
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .gray
        label.text = "Have an account already?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tintColor = UIColor(named: "allServiceSelected")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureConstraints()
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc private func didTapLogin(){
        print("test")
        viewModel.didTapLogin()
    }
    
    private func configureConstraints() {
        
        view.addSubview(registerTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        
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
        
        
        promptLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(registerButton.snp.bottom).offset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(promptLabel.snp.trailing).offset(10)
            make.bottom.equalTo(promptLabel.snp.bottom).offset(7)
        }
    }
}

extension RegisterViewController : RegisterViewInterface {
    func prepareTabbarHidden(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    
}
