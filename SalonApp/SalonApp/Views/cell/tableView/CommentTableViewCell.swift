//
//  CommentTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 24.07.2023.
//

import UIKit
import SnapKit
class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentTableViewCell"
    private let commentText  = "Tam anlaştığımız bir saate geldi. hİç oyalanmadan işe başlayarak çok hızlı bir şekilde gerçekleştirdi. Güvelikle tercih edebilirsiniz"

    private let commenterPersonImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hairdresser")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let commenterPersonLabel : UILabel = {
        let label = UILabel()
        label.text = "Name Surname"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
        
    }()
    
    private let commentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.font  = .systemFont(ofSize: 15)
        label.numberOfLines = 5
      
        label.sizeToFit()
        return label
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(commenterPersonImage)
        contentView.addSubview(commenterPersonLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(ratingImage)
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        commentLabel.text = commentText
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
     }
    
    private func  configureConstraints() {
        commenterPersonImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        commenterPersonLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(commenterPersonImage.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(commenterPersonLabel.snp.top).offset(20)
            make.leading.equalTo(commenterPersonImage.snp.trailing).offset(10)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(commenterPersonLabel.snp.top).offset(20)
            make.leading.equalTo(ratingImage.snp.trailing).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(commenterPersonLabel.snp.top).offset(20)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-10)
           
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingImage.snp.bottom).offset(5)
            make.leading.equalTo(commenterPersonImage.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.height.equalTo(110)
        }
    }
}
