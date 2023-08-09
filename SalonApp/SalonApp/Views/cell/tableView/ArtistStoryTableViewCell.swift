//
//  ArtistStoryTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit

class ArtistStoryTableViewCell: UITableViewCell {

    static let identifier = "ArtistStoryTableViewCell"
    private let artistStoryCollectionView  : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .infinite,collectionViewLayout: layout)
        collectionView.register(ArtistStoryCollectionViewCell.self, forCellWithReuseIdentifier: ArtistStoryCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "backColor")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
   
    var cellProtocol : ArtistStoryTableViewCellProtocol?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(artistStoryCollectionView)
        artistStoryCollectionView.delegate = self
        artistStoryCollectionView.dataSource = self
        
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints(){
        artistStoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(70)
        }
    }
}

protocol ArtistStoryTableViewCellProtocol {
    func toStortViewController(item:Int)
}

extension ArtistStoryTableViewCell :  UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == artistStoryCollectionView else {return UICollectionViewCell()}
        guard let cell = artistStoryCollectionView.dequeueReusableCell(withReuseIdentifier: ArtistStoryCollectionViewCell.identifier, for: indexPath) as? ArtistStoryCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard  collectionView ==  artistStoryCollectionView else {return}
        cellProtocol?.toStortViewController(item: indexPath.item)
        print(indexPath.item)
        
    }
}





