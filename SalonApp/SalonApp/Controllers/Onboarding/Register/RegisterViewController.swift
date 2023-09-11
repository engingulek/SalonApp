//
//  RegisterViewController.swift
//  SalonApp
//
//  Created by engin gülek on 29.07.2023.
//

import UIKit
import SnapKit

protocol RegisterViewInterface : AnyObject,ViewAble,SeguePerformable,NavigaitonBarAble,TabbarSelected{
    func prepareTabbarHidden(isHidden:Bool)
    func alertMessage(isNameAlertHidden:Bool,nameAlertMes:String,
                 isSurnameAlertHidden:Bool,surnameAlertMes:String,
                 isEmailAlertHidden:Bool,emailAlertMes:String,
                 isPasswordAlertHidden:Bool,passwordAlertMes:String)
    func createError(isHidden:Bool,message:String)
}

final class RegisterViewController: UIViewController {
    private lazy var viewModel = RegisterViewModel(view: self)
    private let registerTitleLabel: UILabel = {
          let label = UILabel()
          
          label.text = "Create your account"
          label.font = .systemFont(ofSize: 32, weight: .bold)
          return label
      }()
    
    private let nameTextFied: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.texrFielLogin()
        textField.leftViewMode = .always
        textField.leftView = textField.leftUIView()
        return textField
    }()
    
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(
            string: "Surnma",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.texrFielLogin()
        textField.leftView = textField.leftUIView()
      
      
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.texrFielLogin()
        textField.leftView = textField.leftUIView()
        return textField
    }()
    
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.texrFielLogin()
        textField.leftView = textField.leftUIView()
        textField.rightViewMode = .always
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
    
    private lazy var nameAlertMessageLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor =  UIColor(named: "allServiceSelected")
        return label
    }()
    
    private lazy var surnameAlertMessageLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor =  UIColor(named: "allServiceSelected")
        return label
    }()
    
    
    private lazy var emailalertMessageLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor =  UIColor(named: "allServiceSelected")
        return label
    }()
    
    private lazy var passwordalertMessageLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor =  UIColor(named: "allServiceSelected")
        return label
    }()
    
    private lazy var errorCreateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.backgroundColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureConstraints()
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
    }
    
    @objc private func createAccount(){
        viewModel.createAccount(name: nameTextFied.text ?? "",
                                surname: surnameTextField.text ?? "",
                                email: emailTextField.text ?? "",
                                password: passwordTextField.text ?? "")
    }
    

    
    @objc private func didTapLogin(){
        print("test")
        viewModel.didTapLogin()
    }
    
    private func configureConstraints() {
        
        view.addSubview(registerTitleLabel)
        view.addSubview(nameTextFied)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        view.addSubview(nameAlertMessageLabel)
        view.addSubview(surnameAlertMessageLabel)
        view.addSubview(emailalertMessageLabel)
        view.addSubview(passwordalertMessageLabel)
        view.addSubview(errorCreateLabel)
        
        registerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        
        nameTextFied.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(registerTitleLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        nameAlertMessageLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(nameTextFied.snp.bottom).offset(5)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        
        surnameTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(nameAlertMessageLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
       surnameAlertMessageLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(surnameTextField.snp.bottom).offset(5)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
          
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(surnameAlertMessageLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        emailalertMessageLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(emailalertMessageLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        passwordalertMessageLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(passwordalertMessageLabel.snp.bottom).offset(10)
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
        
        
        errorCreateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(40)
        }
    }
}

extension RegisterViewController : RegisterViewInterface {
    func createError(isHidden: Bool, message: String) {
        errorCreateLabel.isHidden = isHidden
        errorCreateLabel.text = message
    }
    
    func alertMessage(isNameAlertHidden: Bool, nameAlertMes: String, isSurnameAlertHidden: Bool, surnameAlertMes: String, isEmailAlertHidden: Bool, emailAlertMes: String, isPasswordAlertHidden: Bool, passwordAlertMes: String) {
        nameAlertMessageLabel.isHidden = isNameAlertHidden
        surnameAlertMessageLabel.isHidden = isSurnameAlertHidden
        emailalertMessageLabel.isHidden = isEmailAlertHidden
        passwordalertMessageLabel.isHidden = isPasswordAlertHidden
        
        nameAlertMessageLabel.text = nameAlertMes
        surnameAlertMessageLabel.text = surnameAlertMes
        emailalertMessageLabel.text = emailAlertMes
        passwordalertMessageLabel.text = passwordAlertMes
    }
    
    func prepareTabbarHidden(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    
}
