//
//  GenderCVC.swift
//  SalonApp
//
//  Created by engin gülek on 22.07.2023.
//

import UIKit
import SnapKit
class GenderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenderCollectionViewCell"
    
    let genderLabel :  UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(genderLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstraints() {
        genderLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    
}
