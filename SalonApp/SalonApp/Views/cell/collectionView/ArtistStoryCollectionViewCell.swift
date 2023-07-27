//
//  ArtistStoryCollectionViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 27.07.2023.
//

import UIKit
import SnapKit
class ArtistStoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ArtistStoryCollectionViewCell"
    
    private let avatarImageViewBackView : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor(named: "backColor")
        view.layer.cornerRadius = 20
        return view
        
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
         imageView.image = UIImage(named: "person")
        imageView.clipsToBounds = true
        
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
         imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        avatarImageViewBackView.addSubview(avatarImageView)
        contentView.addSubview(avatarImageViewBackView)
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        avatarImageViewBackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
}
