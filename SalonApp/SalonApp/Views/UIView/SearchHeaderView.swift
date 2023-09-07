//
//  SearchHeaderView.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit
class SearchHeaderView: UIView {

        let searchTextFeield : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Find your best Salon",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
 
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchTextFeield)
        backgroundColor = UIColor(named: "homeViewHeaderBackColor")
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        searchTextFeield.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.height.equalTo(40)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)

            
        }
    }
    
}
