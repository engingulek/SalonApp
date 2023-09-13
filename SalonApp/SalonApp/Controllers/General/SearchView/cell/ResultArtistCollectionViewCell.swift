//
//  ResultArtistCollectionViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 3.09.2023.
//

import UIKit
import SnapKit





class ResultArtistCollectionViewCell: UICollectionViewCell {
    static let identifier = "ResultArtistCollectionViewCell"
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
        label.textColor = .lightGray
        label.font  = .systemFont(ofSize: 15)
        return label
    }()
    
    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font  = .systemFont(ofSize: 20,weight: .bold)
        return label
    }()
    
    private let baseServiceNameLabel : UILabel = {
        let label = UILabel()
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
        label.textColor = .lightGray
        label.font  = .systemFont(ofSize: 15)
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
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
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configureData(resultArtist:Artist){
        artistCellImage.kf.setImage(with: URL(string: resultArtist.imageUrl))
        ratingLabel.text = "\(resultArtist.rating)"
        artistNameLabel.text = resultArtist.name
        baseServiceNameLabel.text = resultArtist.bestService
        locaitonLabel.text = resultArtist.locationcity
        priceLabel.text = "$\(resultArtist.pay)"
    }
   
    
    private func configureConstraints() {
        
        contentView.addSubview(artistCellImage)
        contentView.addSubview(ratingImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(baseServiceNameLabel)
        contentView.addSubview(locaitonImage)
        contentView.addSubview(locaitonLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceType)
     
        
        artistCellImage.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.width.equalTo(self.contentView.layer.frame.width / 1.5)
            make.height.equalTo(self.contentView.layer.frame.width / 1.5)
            
        }
        
      
        artistNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(artistCellImage.snp.bottom).offset(10)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.trailing.equalTo(ratingLabel.snp.leading).offset(-5)
            make.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            make.width.equalTo(18)
            make.height.equalTo(18)
           
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(artistNameLabel.snp.bottom).offset(5)
        }
  
        
        baseServiceNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(ratingImage.snp.bottom).offset(10)
        }
        
        locaitonImage.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX).offset(-30)
            make.top.equalTo(baseServiceNameLabel.snp.bottom).offset(10)
        }
        
        locaitonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX).offset(10)
            make.top.equalTo(baseServiceNameLabel.snp.bottom).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX).offset(-15)
            make.top.equalTo(locaitonLabel.snp.bottom).offset(10)
           
        }
        priceType.snp.makeConstraints { make in
            make.bottom.equalTo(priceLabel.snp.bottom).offset(-5)
            make.leading.equalTo(priceLabel.snp.trailing).offset(1)
        }
    }
    
}
