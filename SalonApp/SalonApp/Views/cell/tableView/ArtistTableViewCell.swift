//
//  TopArtistCollectionViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 23.07.2023.
//

import UIKit
import SnapKit
import Kingfisher
protocol ArtistTableViewCellDelegate {
    func selectBookmarkIcon(indexPathRow : Int)
}


class ArtistTableViewCell: UITableViewCell {
    static let identifier = "ArtistCollectionViewCell"
    var cellDelegate : ArtistTableViewCellDelegate?
    var indexPathRow : Int?
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
    
    let bookmarkIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "bookmark")
        imageView.tintColor = UIColor.orange

        imageView.isUserInteractionEnabled = true
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(artistCellImage)
        contentView.addSubview(ratingImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(baseServiceNameLabel)
        contentView.addSubview(locaitonImage)
        contentView.addSubview(locaitonLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceType)
        contentView.addSubview(bookmarkIcon)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBookmarkIcon(_:)))
        
        self.bookmarkIcon.addGestureRecognizer(tap)
     

        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let bottomSpace: CGFloat = 10.0 // Let's assume the space you want is 10
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: bottomSpace, right: 10))
     }
    
   @objc func tapBookmarkIcon(_ sender: UITapGestureRecognizer){
       guard let delegate = cellDelegate else {return}
       delegate.selectBookmarkIcon(indexPathRow: indexPathRow!)
    }
    
    func configureData(topArtist:TopArtist){
        artistCellImage.kf.setImage(with: URL(string: topArtist.imageUrl))
        ratingLabel.text = "\(topArtist.rating)"
        artistNameLabel.text = topArtist.name
        baseServiceNameLabel.text = topArtist.bestService
        locaitonLabel.text = topArtist.locationcity
        priceLabel.text = "$\(topArtist.pay)"
        
    }
    
    
   private func configureConstraints() {
        artistCellImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(self.contentView.layer.frame.width / 2.5)
            make.height.equalTo(self.contentView.layer.frame.width / 2)
        }
        
        bookmarkIcon.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(artistCellImage.snp.trailing).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalTo(ratingImage.snp.trailing).offset(10)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImage.snp.bottom).offset(5)
            make.leading.equalTo(artistCellImage.snp.trailing).offset(10)
        }
        
        baseServiceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(artistCellImage.snp.trailing).offset(10)
        }
        
        locaitonImage.snp.makeConstraints { make in
            make.top.equalTo(baseServiceNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(artistCellImage.snp.trailing).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        
        locaitonLabel.snp.makeConstraints { make in
            make.top.equalTo(baseServiceNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(locaitonImage.snp.trailing).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(locaitonImage.snp.bottom).offset(5)
            make.leading.equalTo(artistCellImage.snp.trailing).offset(10)
        }
        priceType.snp.makeConstraints { make in
            make.bottom.equalTo(priceLabel.snp.bottom).offset(-5)
            make.leading.equalTo(priceLabel.snp.trailing).offset(1)
        }


    }
}
