//
//  BookMarkViewController.swift
//  SalonApp
//
//  Created by engin gülek on 8.08.2023.
//

import UIKit
import SnapKit
protocol BookMarkViewInterface : AnyObject,ViewAble,SeguePerformable,NavigaitonBarAble {
    func prepareTableView()
    func prepareTabbarHidden(isHidden:Bool)
    func reloadDataTableView()
    func indicator(animate:Bool)
}
final class BookMarkViewController: UIViewController {

    private lazy var viewModel = BookMarkListViewModel(view: self)
    private let artistTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ArtistTableViewCell.self, forCellReuseIdentifier: ArtistTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
  
        return tableView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // BUDA INTERDACE ALINACAK
       
      
        viewModel.viewDidLoad()
     
        configureConstraints()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    
    private func configureConstraints() {
        view.addSubview(artistTableView)
        view.addSubview(indicator)
        artistTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
        }
    }
}

extension BookMarkViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.artistTableView {
            guard let cell = artistTableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,
                                                                    for: indexPath) as? ArtistTableViewCell else {
                return UITableViewCell()
            }
            
            let item = viewModel.cellForRowAt(at: indexPath)
            let artist = TopArtist(id: item.artist.artistId,
                                   imageUrl: item.artist.imageUrl,
                                   rating: item.artist.rating,
                                   name: item.artist.name,
                                   bestService: item.artist.bestService,
                                   locationcity: item.artist.locationcity,
                                   pay: item.artist.pay)
            cell.configureData(topArtist: artist, iconType: item.iconType)
            cell.indexPathRow = indexPath.row
            cell.cellDelegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(named: "backColor")
          
           
           
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        viewModel.didSelectItem(at: indexPath)
    }
}

extension BookMarkViewController : ArtistTableViewCellDelegate {
    func selectBookmarkIcon(indexPathRow: Int) {
        viewModel.trashTapIcon(row: indexPathRow)
    }
    
    
}

extension BookMarkViewController : BookMarkViewInterface {
   
    
    func prepareTableView() {
        artistTableView.delegate = self
        artistTableView.dataSource = self
        artistTableView.reloadData()
    }
    
    func prepareTabbarHidden(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    
    func reloadDataTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.artistTableView.reloadData()
        }
    }
    
    func indicator(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
                   guard let self = self else { return }
                   animate ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            self.indicator.isHidden = !animate
               }
    }
    
    
}


