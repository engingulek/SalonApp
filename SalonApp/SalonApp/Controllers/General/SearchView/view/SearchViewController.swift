//
//  SearchViewController.swift
//  SalonApp
//
//  Created by engin gülek on 25.07.2023.
//

import UIKit
import SnapKit

protocol SearchViewInterface : AnyObject,SeguePerformable,NavigaitonBarAble,ViewAble  {
    func prepareTableView()
    func reloadDataTableView()
    func prepareTabbarHidden(isHidden:Bool)
}

final class SearchViewController: UIViewController {
   
    private lazy var headerView = SearchHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 5 ))
    private lazy var viewModel = SearchViewModel(view: self)
   // var searchText : String = ""
    var sections : [TableSection] = [.allService,.resultArtist]
    
    private let allResultTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configureContraints()
       // headerView.searchTextFeield.text = searchText
        sections.forEach { section in
            section.register(tableView: allResultTableView)
        }
    }
  
    
    func getSearchText(searchText:String) {
        self.headerView.searchTextFeield.text = viewModel.writeSearchText(searchText: searchText)
    }
    
    private func configureContraints(){
        view.addSubview(headerView)
        view.addSubview(allResultTableView)
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
        return viewModel.numberOfRowsInSection(section: sections[section])
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView  =  SearchCellHeader()
        headerView.backgroundColor = UIColor(named: "backColor")
        headerView.headerLabel.text = viewModel.viewForHeaderInSection(section: sections[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(section: sections[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: sections[section])

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Story tıklanmasıdan hata çıkar ise
        // cell.cellProtocel dan kaynaklanabili.r
        let cell = viewModel.cellForRowAt(indexPath: indexPath, section: sections[indexPath.section],tableView:allResultTableView)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(section: sections[indexPath.section] )
    }
}


extension SearchViewController : SearchViewInterface {
  
    func prepareTableView() {
        allResultTableView.delegate = self
        allResultTableView.dataSource = self
        allResultTableView.reloadData()
    }
    
    func prepareTabbarHidden(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    func reloadDataTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.allResultTableView.reloadData()
        }
    }
}













