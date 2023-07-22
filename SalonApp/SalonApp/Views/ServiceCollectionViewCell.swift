//
//  ServiceCollectionViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 22.07.2023.
//

import UIKit
import SnapKit
class ServiceCollectionViewCell: UICollectionViewCell {
    static let identifier = "ServiceCollectionViewCell"
    
    
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
        label.font = .systemFont(ofSize: 15,weight: .semibold)
        return label
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(serviceImageView)
        addSubview(serviceNameLabel)
        configureConstraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints(){
        serviceImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        
        serviceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceImageView.snp.bottom).offset(5)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
   
}
