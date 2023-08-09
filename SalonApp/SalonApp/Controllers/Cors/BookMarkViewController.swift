//
//  BookMarkViewController.swift
//  SalonApp
//
//  Created by engin gülek on 8.08.2023.
//

import UIKit
import SnapKit
class BookMarkViewController: UIViewController {

    private let artistTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
  
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Bookmark List"
        view.backgroundColor = UIColor(named: "backColor")
        view.addSubview(artistTableView)
        configureConstraints()
        artistTableView.delegate = self
        artistTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configureConstraints() {
        artistTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension BookMarkViewController : UITableViewDelegate,UITableViewDataSource,ArtistTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.artistTableView {
            guard let cell = artistTableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,
                                                                    for: indexPath) as? ArtistTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            cell.indexPathRow = indexPath.row
            cell.bookmarkIcon.image =  UIImage(systemName: "bookmark.fill")
            cell.bookmarkIcon.tintColor = UIColor.orange
            cell.cellDelegate = self
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectBookmarkIcon(indexPathRow: Int) {
        print("Book Mark View Controller ")
    }
}


