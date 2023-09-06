//
//  AllServiceCollectionViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit
class AllServiceCollectionViewCell: UICollectionViewCell {
    static let identifier = "AllServiceCollectionViewCell"
    private var serviceName : UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 15,weight: .semibold)
         
         label.text = "Service"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(serviceName)
      
        configureConstraints()
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func configureData(service:AllService){
        serviceName.text = service.name
    }
    private func configureConstraints() {
        serviceName.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerY)
        }
    }
    

    
}
