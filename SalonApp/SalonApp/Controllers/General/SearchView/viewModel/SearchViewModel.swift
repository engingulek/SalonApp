//
//  SearchViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 31.08.2023.
//

import Foundation
import UIKit.UITableView
import UIKit.UITableViewCell


protocol SearchViewModelInterface {
    func viewDidLoad(searchText:String)
    func writeSearchText(searchText:String) -> String
    func numberOfSections() -> Int
    func numberOfRowsInSection(section:TableSection) -> Int
    func viewForHeaderInSection(section:TableSection) -> String
    func heightForRowAt(section:TableSection) -> CGFloat
    func heightForHeaderInSection(section:TableSection) -> CGFloat
    func cellForRowAt(indexPath:IndexPath,section:TableSection,tableView:UITableView) -> UITableViewCell
    func didSelectRowAt(section:TableSection)
}

final class SearchViewModel : SearchViewModelInterface {
   
    
    private weak var view : SearchViewInterface?
    private  let serviceManager : SearchServiceInterface
    private var tableSection : TableSection = .allService
    private var sectionType : TableSection {tableSection }
    var searchArtistList : [TopArtist] = []
    
    init(view: SearchViewInterface,serviceManager :
         SearchServiceInterface = SearchService.shared) {
        self.view = view
        self.serviceManager = serviceManager
    }
    
    func fetchSearchArtist(searchText:String){
        serviceManager.fetchSearchArtist(searchText: searchText.lowercased()) { response in
            switch response {
            case .success(let list):
                self.searchArtistList = list ?? []
                self.view?.reloadDataTableView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    func viewDidLoad(searchText:String) {
        Task {
            @MainActor in
            self.fetchSearchArtist(searchText:searchText)
        }
        view?.prepareTabbarHidden(isHidden: true)
        view?.prepareTableView()
        view?.setBackgroundColor("backColor")
        view?.prepareNavigationBarCollor(colorText: "back")
    }
    
    func writeSearchText(searchText:String) -> String{
        if searchText.isEmpty {
            view?.popViewControllerAble()
            return ""
        }else{
            return searchText
        }
        
    }
    
    func numberOfRowsInSection(section:TableSection) -> Int{
        tableSection = section
        switch tableSection {
        case .allService:
            return 1
        case .resultArtist:
            return self.searchArtistList.count
        }
        
    }
    
    func numberOfSections() -> Int {
        return TableSection.allCases.count
    }
    
    func viewForHeaderInSection(section:TableSection) -> String {
        tableSection = section
        switch tableSection {
        case .allService:
            return "All Service"
        case .resultArtist:
            return "All Artist"
        }
    }
    
    func heightForRowAt(section:TableSection) -> CGFloat {
        tableSection = section
        switch tableSection {
        case .resultArtist:
            return 170
        default:
            return 70
        }
        
    }
    
    func heightForHeaderInSection(section:TableSection) -> CGFloat {
        return 30
    }
    
    
    
    func cellForRowAt(indexPath:IndexPath,section:TableSection,tableView:UITableView) -> UITableViewCell {
        tableSection = section
        switch tableSection {
        case .allService:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AllServiceTableViewCell.identifier,for: indexPath) as? AllServiceTableViewCell
            else {return UITableViewCell()}
            cell.backgroundColor =  UIColor(named: "backColor")
            return cell
        case .resultArtist:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier,for:indexPath) as? ArtistTableViewCell else {return UITableViewCell()}
            let artist = searchArtistList[indexPath.row]
            cell.configureData(topArtist: artist)
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }
         
    }
    
     func didSelectRowAt(section:TableSection){
         tableSection = section
         switch tableSection {
         case .resultArtist:
             let vc = ArtistDetailViewController()
             vc.artistId = 1
             view?.pushViewControllerable(vc, identifier: "ArtistDetailViewControllerIdentifier")
         default:
             break;
         }
    }
    
    func toStortViewController(item:Int){
        let vc = StroyViewController()
        vc.index = item
        view?.pushViewControllerable(vc, identifier: "StortViewControllerIndetifier")
        
    }
    
   
}
