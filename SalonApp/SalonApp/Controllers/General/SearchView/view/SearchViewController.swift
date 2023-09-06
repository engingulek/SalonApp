//
//  SearchViewController.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit

fileprivate let ALL_SERVICE : Int = 0
fileprivate let RESULT_ARTIST : Int = 1

protocol SearchViewInterface : AnyObject,SeguePerformable,NavigaitonBarAble,ViewAble  {
    func prepareColllectionView()
    func reloadDataColllectionView()
    func prepareTabbarHidden(isHidden:Bool)
}

final class SearchViewController: UIViewController {
   
    private lazy var headerView = SearchHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 5 ))
    private lazy var viewModel = SearchViewModel(view: self)
    var searchText : String = ""
    var sections : [TableSection] = [.allService,.resultArtist]
    
    
   private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor(named: "backColor")
     
       collectionView.register(AllServiceCollectionViewCell.self, forCellWithReuseIdentifier: AllServiceCollectionViewCell.identifier)
       collectionView.register(ResultArtistCollectionViewCell.self, forCellWithReuseIdentifier: ResultArtistCollectionViewCell.identifier)
      
       
        return collectionView
    }()
    
    
  private  func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if ALL_SERVICE == section {
                return LayoutBuilder.buildAllServiceSectionLayout()
            } else {
                return LayoutBuilder.buildResultArtistSectionLayout()
            }
        }
        return layout
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad(searchText: searchText)
        configureContraints()
        headerView.searchTextFeield.text = searchText
        collectionView.register(SearchCellHeader.self, forSupplementaryViewOfKind:
                                    UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        setBackgroundColor("backColor")
        headerView.searchTextFeield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        sortMenuConstraints()
        
      
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            searchText = text
            viewModel.searchAction(searchText: text)
        }
       
    }
    
    @objc func addTapped() {
        print("Test")
    }
    
    private func sortMenuConstraints(){
        let priceDesc = UIAction(title: "Price Descending") { _ in self.viewModel.fetchSearchArtistPayDesc()}
        let priceAsc = UIAction(title: "Price Increasing") { _ in self.viewModel.fetchSearchArtistPayAsc()}
        let hightRating = UIAction(title: "Hight Rating") { _ in self.viewModel.fetchSearchArtistPayHightRating()}
        let menu = UIMenu(title: "Sort Type", options: .displayInline, children: [priceDesc , priceAsc , hightRating])
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "arrow.up.arrow.down"))
        navigationItem.rightBarButtonItem!.menu = menu
    }
  
    private func configureContraints(){
        view.addSubview(headerView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if ALL_SERVICE == indexPath.section {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllServiceCollectionViewCell.identifier, for: indexPath) as? AllServiceCollectionViewCell {
                let item = viewModel.cellForItemAt(section: indexPath.section, indexPath: indexPath)
                cell.configureData(service: item.service!)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
       
        if RESULT_ARTIST == indexPath.section {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultArtistCollectionViewCell.identifier, for: indexPath) as? ResultArtistCollectionViewCell {
                cell.backgroundColor = .white
                cell.layer.cornerRadius = 20
                let item = viewModel.cellForItemAt(section: indexPath.section, indexPath: indexPath)
                cell.configureData(resultArtist: item.artist!)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(section: indexPath.section, indexPath: indexPath)
    }
}


extension SearchViewController : SearchViewInterface {
    func prepareColllectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func reloadDataColllectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.reloadData()
        }
    }
    
    func prepareTabbarHidden(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
}













