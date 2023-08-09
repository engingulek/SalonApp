//
//  ChatTextHeaderView.swift
//  SalonApp
//
//  Created by engin gülek on 28.07.2023.
//

import UIKit
import SnapKit
class ChatTextView: UIView {
    
    private let messageTextField :  UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Message...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return textField

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(messageTextField)
        backgroundColor = .white
        configureConstraints()
       
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        messageTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            
        }
    }
}
