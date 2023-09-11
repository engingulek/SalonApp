//
//  LoginViewController.swift
//  SalonApp
//
//  Created by engin gülek on 29.07.2023.
//

import UIKit
import SnapKit
protocol LoginViewInterface : AnyObject,ViewAble,NavigaitonBarAble {
    func alertMessage(isHiddenEmailMes:Bool,
                      isHiddenPassMes:Bool,
                      emailMes:String,
                      pasmessage:String,
                      emailColor:String,
                      passcolor:String)
  
 
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
    
    private let emailalertMessageLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor =  UIColor(named: "allServiceSelected")
        return label
    }()
    
    private let passwordalertMessageLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor =  UIColor(named: "allServiceSelected")
        return label
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
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(named: "allServiceSelected")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
     
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureConstraints()
        
       
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

      
    }
    
 
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.controlEmail(email:  textField.text ?? "")
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.controlPassword(password: textField.text ?? "")
    }
    

    
    @objc private func loginAction(){
        viewModel.login(email: emailTextField.text ?? "",
                        password: passwordTextField.text ?? "")
    }
    
    
    private func configureConstraints() {
        view.addSubview(loginTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailalertMessageLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordalertMessageLabel)
        
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
        
        emailalertMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo( emailalertMessageLabel.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
        
        passwordalertMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading).offset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
    }
}

extension LoginViewController : LoginViewInterface {
    func alertMessage(isHiddenEmailMes: Bool,
                      isHiddenPassMes: Bool,
                      emailMes: String,
                      pasmessage: String,
                      emailColor: String,
                      passcolor: String) {
        
        emailalertMessageLabel.isHidden = isHiddenEmailMes
        passwordalertMessageLabel.isHidden = isHiddenPassMes
        emailalertMessageLabel.text = emailMes
        passwordalertMessageLabel.text = pasmessage
        passwordTextField.layer.borderColor = UIColor(named: passcolor)?.cgColor
        emailTextField.layer.borderColor = UIColor(named: emailColor)?.cgColor
        
    }
    

    
  
    
  
    
    
}
