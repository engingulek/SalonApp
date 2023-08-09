//
//  AllResultTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit
class AllServiceTableViewCell: UITableViewCell {
    var lastIndexSelection:IndexPath = [0,0]
    private enum AllServiceList : String,CaseIterable {
        case all = "All"
        case hairStyle = "HairStyle"
        case beautySpa = "Beauty & Spa"
        case makeup = "Makeup"
        case test = "test"
    }
    static let identifier = "AllResultTableViewCell"
    private let allServiceCollectionView  : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 40)
        let collectionView = UICollectionView(frame: .infinite,collectionViewLayout: layout)
        collectionView.register(AllServiceCollectionViewCell.self, forCellWithReuseIdentifier: AllServiceCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "backColor")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(allServiceCollectionView)
        allServiceCollectionView.dataSource = self
        allServiceCollectionView.delegate = self
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints(){
        allServiceCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(50)
        }
    }
}

extension AllServiceTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllServiceList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == allServiceCollectionView {
            guard let cell = allServiceCollectionView.dequeueReusableCell(withReuseIdentifier: AllServiceCollectionViewCell.identifier, for: indexPath) as? AllServiceCollectionViewCell else {
                return UICollectionViewCell()}
            let serviceName = AllServiceList.allCases[indexPath.row]
            cell.serviceName.text = serviceName.rawValue
            cell.serviceName.textColor = UIColor(named: "allService")
            if self.lastIndexSelection == indexPath  {
                cell.serviceName.textColor = UIColor(named: "allServiceSelected")
            }
           return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == allServiceCollectionView {
            if lastIndexSelection != indexPath {
                
                guard let cellSelection = self.allServiceCollectionView.cellForItem(at: indexPath) as? AllServiceCollectionViewCell else {return}
                cellSelection.serviceName.textColor = UIColor(named: "allServiceSelected")
                guard let cellSelectionOld = self.allServiceCollectionView.cellForItem(at: self.lastIndexSelection) as? AllServiceCollectionViewCell else {return}
                cellSelectionOld.serviceName.textColor = UIColor(named: "allService")
                self.lastIndexSelection = indexPath
            }
        }
    }

    
    
}
