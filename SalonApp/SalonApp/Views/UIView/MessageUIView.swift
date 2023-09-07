//
//  MessageUIView.swift
//  SalonApp
//
//  Created by engin gülek on 7.09.2023.
//

import UIKit
import SnapKit
class MessageUIView: UIView {

    private lazy var messageIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var alertMessage: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(messageIcon)
        addSubview(alertMessage)
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureConstraint(){
        messageIcon.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY).offset(-10)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        alertMessage.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(messageIcon.snp.bottom).offset(20)
        }
    }
    
    func configureData(icon:String,message:String){
        messageIcon.image =  UIImage(named: icon)
        alertMessage.text = message
    }
    
}
