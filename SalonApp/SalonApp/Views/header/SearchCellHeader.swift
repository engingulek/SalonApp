//
//  SearchCellHeader.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit
class SearchCellHeader: UIView {

     let headerLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16,weight: .bold)
       return label
    }()
    
    let sortBy : UIButton = {
       let button = UIButton()
        button.setTitle("Sort by", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16,weight: .bold)
        button.setTitleColor(UIColor(named: "allServiceSelected"), for: .normal)
        button.isHidden = true
        button.isEnabled = false
        button.showsMenuAsPrimaryAction = true
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        addSubview(sortBy)
        configureConstraints()
        sortBy.menu = addMenuItems()
    }
    
    private func addMenuItems() -> UIMenu {
        let menuItems = UIMenu(title: "",options: .displayInline,children: [
            UIAction(title: "Price (Growing)", handler: { (_) in
                print("Price (Growing)")
            }),
            
            UIAction(title: "Price (Decrasing)", handler: { (_) in
                print("Price (Decrasing)")
            }),
            
            UIAction(title: "High Score", handler: { (_) in
                print("High Score")
            })


        
        ])
        return menuItems
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints(){
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(6)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
        }
        
        sortBy.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
        }
       
    }

}
