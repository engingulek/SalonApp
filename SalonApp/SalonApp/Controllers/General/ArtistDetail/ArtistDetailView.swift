//
//  ArtistDetailView.swift
//  SalonApp
//
//  Created by engin gülek on 23.07.2023.
//

import UIKit
import SnapKit
import Kingfisher
class ArtistDetailView: UIView {
    private let artistCellImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hairdresser")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    
    private let ratingImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor.orange
        
        return imageView
    }()
    
    private let ratingLabel : UILabel = {
        let label = UILabel()
        label.text = "3.5"
        label.textColor = .lightGray
        label.font  = .systemFont(ofSize: 15)
        return label
    }()
    
    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Sara Terry"
        label.textColor = .black
        label.font  = .systemFont(ofSize: 20,weight: .bold)
        return label
    }()
    
    private let baseServiceNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Facial Artist"
        label.font = .systemFont(ofSize: 15,weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    private let locaitonImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "mappin.circle")
        imageView.tintColor = UIColor.blue
        
        return imageView
    }()
    
    private let locaitonLabel : UILabel = {
        let label = UILabel()
        label.text = "Istanbul"
        label.textColor = .lightGray
        label.font  = .systemFont(ofSize: 15)
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "$40.00"
        label.textColor = .black
        label.font  = .systemFont(ofSize: 20,weight: .bold)
        return label
    }()
    
    private let priceType:UILabel = {
        let label = UILabel()
        label.text = "/Hour"
        label.textColor = .lightGray
        label.font  = .systemFont(ofSize: 10,weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "homeViewHeaderBackColor")
        addSubview(artistCellImage)
        addSubview(ratingImage)
        addSubview(ratingLabel)
        addSubview(artistNameLabel)
        addSubview(baseServiceNameLabel)
        addSubview(locaitonImage)
        addSubview(locaitonLabel)
        addSubview(priceLabel)
        addSubview(priceType)
       
        configureConstraints()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(artistDetail:ArtistDetail) {
        artistNameLabel.text = artistDetail.name
        ratingLabel.text =  "\(artistDetail.rating)"
        baseServiceNameLabel.text = artistDetail.bestService
        locaitonLabel.text = artistDetail.locationcity
        priceLabel.text = "$\(artistDetail.pay)"
        artistCellImage.kf.setImage(with: URL(string: artistDetail.imageUrl))
      
    }
    
    private func configureConstraints() {
        
        artistCellImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(self.layer.frame.width / 2.5)
            make.height.equalTo(self.layer.frame.width / 2)
        }
        
      
        
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(ratingImage.snp.trailing).offset(10)
        }
        
     
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImage.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        baseServiceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        locaitonImage.snp.makeConstraints { make in
            make.top.equalTo(baseServiceNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        
        locaitonLabel.snp.makeConstraints { make in
            make.top.equalTo(baseServiceNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(locaitonImage.snp.trailing).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(locaitonImage.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        priceType.snp.makeConstraints { make in
            make.bottom.equalTo(priceLabel.snp.bottom).offset(-5)
            make.leading.equalTo(priceLabel.snp.trailing).offset(1)
        }

    }
}
