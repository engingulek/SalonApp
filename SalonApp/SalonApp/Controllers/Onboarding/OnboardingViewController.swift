//
//  OnboardingViewController.swift
//  SalonApp
//
//  Created by engin gülek on 29.07.2023.
//

import UIKit
import SnapKit
class OnboardingViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Let the beauty come to you"
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = UIColor(named: "allServiceSelected")
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.layer.cornerRadius = 30
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
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        configureConstraints()
    }
    
    
    @objc private func didTapLogin(){
        print("test")
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapCreateAccount() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func configureConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.width.equalTo(welcomeLabel.snp.width).offset(-20)
            make.height.equalTo(60)
            
        }
        
        promptLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.bottom.equalTo(view.snp.bottom).offset(-60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerY.equalTo(promptLabel.snp.centerY)
            make.leading.equalTo(promptLabel.snp.trailing).offset(10)
        }
    }
    


}
