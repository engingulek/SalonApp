//
//  ViewController.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {

    private lazy var headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 4 ))
    
    private let searchTextFeield : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Find your best Salon",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.backgroundColor =  UIColor(named: "searchTextFieldBackColor")
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
 
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(searchTextFeield)
        configureConstraints()
    
        
    }
    
    private func configureConstraints() {
        searchTextFeield.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
}

