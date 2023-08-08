//
//  ProfileViewController.swift
//  SalonApp
//
//  Created by engin gülek on 8.08.2023.
//

import UIKit
import SnapKit
class ProfileViewController: UIViewController {
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
         imageView.image = UIImage(named: "person")
         imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let selectProfilImageButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(named: "allServiceSelected")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()
    
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Engin"
        textField.font = .systemFont(ofSize: 20)
        return textField
    }()
    
    
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20)
        textField.text = "Gülek"
        return textField
    }()
    
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.text = "engingulek0@gmail.com"
        textField.font = .systemFont(ofSize: 20)
       
        return textField
    }()
    
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "1234567890"
        textField.font = .systemFont(ofSize: 20)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        self.navigationItem.title = "Profil"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        view.addSubview(profileAvatarImageView)
        view.addSubview(selectProfilImageButton)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        configureConstraints()
    }
    
    @objc private func saveButtonTapped(){
        let alert = UIAlertController(title: "Save", message: "Are you sure about the changes", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .cancel) { _ in
            self.tabBarController?.selectedIndex = 0
        }
        let noAction = UIAlertAction(title: "No", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
    }
    
    func configureConstraints() {
        profileAvatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(25)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        selectProfilImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileAvatarImageView.safeAreaLayoutGuide.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        
        
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(selectProfilImageButton.snp.bottom).offset(25)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        
        
        surnameTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(surnameTextField.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        
        
        
        let width = view.frame.width - 40
        
        surnameTextField.addBorder(width)
        emailTextField.addBorder(width)
        passwordTextField.addBorder(width)
        
    }


}
