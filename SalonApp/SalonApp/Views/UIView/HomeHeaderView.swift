//
//  HomeView.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit
import SnapKit
class HomeHeaderView: UIView {
    
   private let profileAvatarImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.clipsToBounds = true
       imageView.layer.masksToBounds = true
       imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "person")
       imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleToFill
       return imageView
   }()
    
    
    private let headerLabel : UILabel = {
        let label = UILabel()
        label.text = "Hi!"
        label.font = .systemFont(ofSize: 20,weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let displayNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Engin Gülek"
        label.font = .systemFont(ofSize: 18,weight: .light)
        label.textColor = .black
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileAvatarImageView)
        addSubview(headerLabel)
        addSubview(displayNameLabel)
        backgroundColor = UIColor(named: "homeViewHeaderBackColor")
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        displayNameLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        profileAvatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(25)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
