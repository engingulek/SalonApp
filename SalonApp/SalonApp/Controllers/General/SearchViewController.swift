//
//  SearchViewController.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit



class SearchViewController: UIViewController {
    private lazy var headerView = SearchHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 5 ))
    var searchText : String = ""
    enum TableSection : CaseIterable {
        case allService
        case resultArtistStory
        case resultArtist
        
        func numberOfItems() -> Int {
            switch self {
            case .allService:
                return 2
            case .resultArtistStory:
                return 1
            case .resultArtist:
                return 1
            }
        }
        
        func sectionTitle() -> String{
                  switch self {
                  case .allService:
                      return ""
                  case .resultArtistStory:
                      return "Artist Story"
                  case .resultArtist:
                      return "Result Artist"
                  }
              }
        func register(tableView : UITableView){
            switch self {
            case .allService:
                tableView.register(AllServiceTableViewCell.self, forCellReuseIdentifier: AllServiceTableViewCell.identifier)
                
            case .resultArtistStory:
                tableView.register(ArtistStoryTableViewCell.self, forCellReuseIdentifier: ArtistStoryTableViewCell.identifier)
                
            case .resultArtist:
                tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
                
            }
        }
    
    }
    
    var sections : [TableSection] = [.allService,.resultArtistStory,.resultArtist]
    
    private let allResultTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        view.addSubview(headerView)
        view.addSubview(allResultTableView)
        configureContraints()
        allResultTableView.delegate = self
        allResultTableView.dataSource = self
        headerView.searchTextFeield.text = searchText
        sections.forEach { section in
            section.register(tableView: allResultTableView)
        }
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func configureContraints(){
        allResultTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    
}

extension SearchViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .allService:
            return 1
        case .resultArtistStory:
            return 1
        case .resultArtist:
            return 5
        }
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.allCases.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView  =  SearchCellHeader()
        headerView.backgroundColor = UIColor(named: "backColor")
        switch sections[section] {
        case .allService:
            headerView.headerLabel.text = "All Service"
        case .resultArtistStory:
            headerView.headerLabel.text = "Artist Story"
        case .resultArtist:
            headerView.headerLabel.text = "Artist Result"
            headerView.sortBy.isHidden = false
            headerView.sortBy.isEnabled = true
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section]{
        case .resultArtist:
            return 170
        default:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section]{
        case .allService:
            guard let cell = allResultTableView.dequeueReusableCell(withIdentifier: AllServiceTableViewCell.identifier,for: indexPath) as? AllServiceTableViewCell
            else {return UITableViewCell()}
            cell.backgroundColor =  UIColor(named: "backColor")
            return cell
        case .resultArtistStory:
            guard let cell = allResultTableView.dequeueReusableCell(withIdentifier: ArtistStoryTableViewCell.identifier ,for: indexPath) as? ArtistStoryTableViewCell else {return UITableViewCell()}
            cell.backgroundColor =  UIColor(named: "backColor")
            cell.cellProtocol = self
            return cell
        case .resultArtist:
            guard let cell = allResultTableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,for:indexPath) as? ArtistTableViewCell else {return UITableViewCell()}
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section]{
        case .resultArtist:
            let vc = ArtistDetailViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension SearchViewController : ArtistStoryTableViewCellProtocol {
    func toStortViewController(item: Int) {
        let vc = StroyViewController()
        vc.index = item
        navigationController?.pushViewController(vc, animated: true)
    }
}













