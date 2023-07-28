//
//  ChatListTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 28.07.2023.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    static let identifier = "ChatListTableViewCel"
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
    
    private let nameSurnameLabel : UILabel = {
       let label = UILabel()
        label.text = "Engin Gülek"
        label.font = .systemFont(ofSize: 18,weight: .bold)
        return label
    }()
    
    private let lastMessageLabel : UILabel = {
       let label = UILabel()
        label.text = "Last Message"
        label.textColor =  .black
        label.font = .systemFont(ofSize: 15,weight: .light)
        return label
    }()
    
    
    private let lastMessageDateLabel : UILabel = {
       let label = UILabel()
        label.text = "28.07.2023"
        label.textColor =  .black
        label.font = .systemFont(ofSize: 15,weight: .light)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileAvatarImageView)
        contentView.addSubview(nameSurnameLabel)
        contentView.addSubview(lastMessageLabel)
        contentView.addSubview(lastMessageDateLabel)
        contentView.backgroundColor = UIColor(named: "backColor")
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        profileAvatarImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        nameSurnameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(profileAvatarImageView.snp.trailing).offset(10)
            
        }
        
        lastMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameSurnameLabel.snp.bottom).offset(5)
            make.leading.equalTo(profileAvatarImageView.snp.trailing).offset(10)
        }
        
        lastMessageDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
        }
        
    }
    
    
   


}
