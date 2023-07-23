//
//  ViewController.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit
import SnapKit




class HomeViewController: UIViewController {

    private lazy var headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 4 ))
    
    private let searchTextFeield : UITextField = {
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

    private let serviceTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Top Services"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18,weight: .bold)
        return label
    }()
    
    
    private let serviceCollectionView  : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .infinite,collectionViewLayout: layout)
        collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: ServiceCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "backColor")
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        view.addSubview(headerView)
        view.addSubview(searchTextFeield)
      
        view.addSubview(serviceTitleLabel)
        view.addSubview(serviceCollectionView)
        configureConstraints()
        
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        
    }
    
    private func configureConstraints() {
        searchTextFeield.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
       
        
        serviceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextFeield.snp.bottom).offset(20)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(15)
            
        }
        
        serviceCollectionView.snp.makeConstraints { make in
            make.top.equalTo(serviceTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(80)
        }
    }
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        
       
        
         if collectionView == self.serviceCollectionView {
            guard let cell =  serviceCollectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.identifier,
                                                                       for: indexPath) as? ServiceCollectionViewCell else {
                return UICollectionViewCell()
            }
           
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 20
            return cell
        }
        else {
            return UICollectionViewCell()
        }
        
       
    }
    
    
    
   
    
    
   
    
    
}
