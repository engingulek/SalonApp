//
//  ArtistServiceTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 23.07.2023.
//

import UIKit

class ArtistServiceTableViewCell: UITableViewCell {
    static let identifier = "ArtistServiceTableViewCell"
    
    private let serviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:  "salon")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        imageView.contentMode = .scaleToFill
       return imageView
    }()
    
     let serviceNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(serviceImageView)
        contentView.addSubview(serviceNameLabel)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
     }
    
    func  configureConstraints() {
        serviceImageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        
        serviceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(serviceImageView.snp.trailing).offset(10)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
