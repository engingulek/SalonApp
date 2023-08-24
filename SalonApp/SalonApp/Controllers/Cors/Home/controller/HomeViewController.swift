//
//  ViewController.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit
import SnapKit

protocol HomeViewInterface : AnyObject,SeguePerformable {
    func prepareCollectionView()
    func prepareTableView()
    func prepareTabbarHidden(isHidden:Bool)
    func prepareTextFieldController(text:String)
    func reloadData()
}

final class HomeViewController: UIViewController {
    private lazy var headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 4 ))
    private var status = true
    private lazy var viewModel = HomeViewModel(view: self)
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
    
    private let topArtistLabel : UILabel = {
        let label = UILabel()
        label.text = "Top Artist"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18,weight: .bold)
        return label
    }()
    
    private let artistTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureConstraints()
        searchTextFeield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
        
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        viewModel.textFieldDidChange(text)
    }
    
    private func configureConstraints() {
        view.backgroundColor = UIColor(named: "backColor")
        view.addSubview(headerView)
        view.addSubview(searchTextFeield)
        view.addSubview(serviceTitleLabel)
        view.addSubview(serviceCollectionView)
        view.addSubview(topArtistLabel)
        view.addSubview(artistTableView)
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
        
        
        topArtistLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        artistTableView.snp.makeConstraints { make in
            make.top.equalTo(topArtistLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension HomeViewController : ArtistTableViewCellDelegate {
    func selectBookmarkIcon(indexPathRow: Int) {
        print("HomeViewController \(indexPathRow)")
    }
}

extension HomeViewController : HomeViewInterface {
    
    
    
    func prepareTableView() {
        artistTableView.delegate = self
        artistTableView.dataSource = self
        artistTableView.reloadData()
    }
    
    func prepareTextFieldController(text:String) {
        searchTextFeield.text = text
    }
    
    func prepareTabbarHidden(isHidden:Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    func prepareCollectionView() {
        serviceCollectionView.delegate = self
        serviceCollectionView.dataSource = self
        serviceCollectionView.reloadData()
    }
    
    func reloadData() {
        artistTableView.reloadData()
        serviceCollectionView.reloadData()
    }
    
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == self.serviceCollectionView {
            guard let cell =  serviceCollectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.identifier,
                                                                       for: indexPath) as? ServiceCollectionViewCell else {
                return UICollectionViewCell()
            }
             
             let item = viewModel.cellForItemAt(at: indexPath)
             cell.backgroundColor = UIColor(named: item.backColor)
             cell.layer.borderColor = UIColor(named: item.boderColor)?.cgColor
             cell.configureData(topService: item.topService)
             cell.layer.cornerRadius = 20
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.artistTableView {
            guard let cell = artistTableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,
                                                                    for: indexPath) as? ArtistTableViewCell else {
                return UITableViewCell()
            }
           let item =  viewModel.cellForRowAt(at: indexPath)
           cell.configureData(topArtist: item.topArtist)
            cell.cellDelegate = self
            cell.indexPathRow = indexPath.row
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}






