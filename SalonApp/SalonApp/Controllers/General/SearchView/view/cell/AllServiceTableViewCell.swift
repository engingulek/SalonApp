//
//  AllResultTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit
protocol AllServiceTableViewCellInterface : AnyObject {
    func prepareCollectionView()
    func reloadDataColletionView()
    func indicatoView(animate:Bool)
}

class AllServiceTableViewCell: UITableViewCell {
    var lastIndexSelection:IndexPath = [0,0]
  
    static let identifier = "AllResultTableViewCell"
    private lazy var viewModel = AllServiceTableViewCellViewModel(view: self)
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
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
       
        viewModel.viewDidLoad()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints(){
        contentView.addSubview(allServiceCollectionView)
        contentView.addSubview(indicator)
        allServiceCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(50)
        }
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerY)
        }
    }
}

extension AllServiceTableViewCell: AllServiceTableViewCellInterface{
    func prepareCollectionView() {
        allServiceCollectionView.dataSource = self
        allServiceCollectionView.delegate = self
        allServiceCollectionView.reloadData()
    }
    
    func reloadDataColletionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.allServiceCollectionView.reloadData()
        }
    }
    
    func indicatoView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
                   guard let self = self else { return }
                   animate ? self.indicator.startAnimating() : self.indicator.stopAnimating()
                   self.indicator.isHidden = !animate
               }
    }
}

extension AllServiceTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == allServiceCollectionView {
            guard let cell = allServiceCollectionView.dequeueReusableCell(withReuseIdentifier: AllServiceCollectionViewCell.identifier, for: indexPath) as? AllServiceCollectionViewCell else {
                return UICollectionViewCell()}
            let item = viewModel.cellForItemAt(at: indexPath)
            cell.configureData(service: item.service)
            cell.serviceName.textColor = UIColor(named: item.textColor)
           return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == allServiceCollectionView {
            if viewModel.selectedService != indexPath {
                let item = viewModel.didSelectItemAt(at: indexPath)
                    
                    guard let cellSelection = self.allServiceCollectionView.cellForItem(at: indexPath) as? AllServiceCollectionViewCell else {return}
                cellSelection.serviceName.textColor = UIColor(named: item.selectedTextColor)
                guard let cellSelectionOld = self.allServiceCollectionView.cellForItem(at: viewModel.selectedService) as? AllServiceCollectionViewCell else {return}
                cellSelectionOld.serviceName.textColor = UIColor(named: item.textColor)
                print(viewModel.selectedService)
                viewModel.changeLastSelected(at: indexPath)
            }
        }
    }
}
