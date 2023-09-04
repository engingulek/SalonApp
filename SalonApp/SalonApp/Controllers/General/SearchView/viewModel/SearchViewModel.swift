//
//  SearchViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 31.08.2023.
//

import Foundation
import UIKit.UITableView
import UIKit.UITableViewCell

fileprivate let ALL_SERVICE : Int = 0
fileprivate let RESULT_ARTIST : Int = 1

protocol SearchViewModelInterface {
    func viewDidLoad(searchText:String)
 
    func numberOfSections() -> Int
    func numberOfItemsInSection(section:Int) -> Int
    func cellForItemAt(section:Int,indexPath:IndexPath)->(service: AllService?, artist: TopArtist?)
    func didSelectItem(section:Int,indexPath:IndexPath)
    func searchAction(searchText:String)
 
    
  
}

final class SearchViewModel  {
   
    private weak var view : SearchViewInterface?
    private  let serviceManager : SearchServiceInterface
    var searchArtistList : [TopArtist] = []
    var allServiceList : [AllService] = []
    private var searchTextViewModel : String = ""
    
    init(view: SearchViewInterface,serviceManager :
         SearchServiceInterface = SearchService.shared) {
        self.view = view
        self.serviceManager = serviceManager
    }
    
    
    func fetchAllService(){
        serviceManager.fetchAllService { resonse in
            switch resonse {
            case .success(let list):
                self.allServiceList = list ?? []
                self.view?.reloadDataColllectionView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchSearchArtist(searchText:String){
        if !searchTextViewModel.isEmpty {
            serviceManager.fetchSearchArtist(searchText: searchText.lowercased()) { response in
                switch response {
                case .success(let list):
                    //self.searchArtistList = []
                    self.searchArtistList = list ?? []
                    print(searchText.lowercased())
                    self.view?.reloadDataColllectionView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
    }
    
    func fetchSearchArtistServiFilter(searchText:String,serviceId:Int){
        if !searchTextViewModel.isEmpty {
            serviceManager.fetchSearchArtistFilterService(searchText: searchText.lowercased(),
                                            serviceId: serviceId) { response in
                switch response {
                case .success(let list):
                    //self.searchArtistList = []
                    self.searchArtistList = list ?? []
                    print(searchText.lowercased())
                    self.view?.reloadDataColllectionView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
    }
    
    func fetchSearchArtistPayDesc(){
        if !searchTextViewModel.isEmpty {
            serviceManager.fetchSearchArtistPayDesc(searchText: searchTextViewModel.lowercased()
                                            ) { response in
                switch response {
                case .success(let list):
                    //self.searchArtistList = []
                    self.searchArtistList = list ?? []
                  
                    self.view?.reloadDataColllectionView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
    }
    
    func fetchSearchArtistPayAsc(){
        if !searchTextViewModel.isEmpty {
            serviceManager.fetchSearchArtistPayAsc(searchText: searchTextViewModel.lowercased()
                                            ) { response in
                switch response {
                case .success(let list):
                    //self.searchArtistList = []
                    self.searchArtistList = list ?? []
                 
                    self.view?.reloadDataColllectionView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
    }
    
    func fetchSearchArtistPayHightRating(){
        if !searchTextViewModel.isEmpty {
            serviceManager.fetchSearchArtistHightRating(searchText: searchTextViewModel.lowercased()
                                            ) { response in
                switch response {
                case .success(let list):
                    //self.searchArtistList = []
                    self.searchArtistList = list ?? []
                  
                    self.view?.reloadDataColllectionView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
    }
    
    
}



extension SearchViewModel : SearchViewModelInterface  {
    

    
    func viewDidLoad(searchText:String) {
        Task {
            @MainActor in
            self.fetchSearchArtist(searchText:searchText)
            self.fetchAllService()
        }
        self.searchTextViewModel = searchText
        view?.prepareTabbarHidden(isHidden: true)
        view?.prepareColllectionView()
        view?.setBackgroundColor("backColor")
        view?.prepareNavigationBarCollor(colorText: "black")
    }
    
    func searchAction(searchText: String) {
        Task {
            @MainActor in
            self.fetchSearchArtist(searchText:searchText)
        }
        self.searchTextViewModel = searchText
        view?.prepareColllectionView()
    }
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfItemsInSection(section:Int) -> Int {
        if ALL_SERVICE == section {
            return allServiceList.count
        }
        if RESULT_ARTIST == section {
            return searchArtistList.count
        }
        
        return 0
    }
    
    func cellForItemAt(section:Int,indexPath:IndexPath) -> (service: AllService?, artist: TopArtist?) {
        var service : AllService? = nil
        var artist: TopArtist? = nil
        
        if ALL_SERVICE == section {
            service = allServiceList[indexPath.item]
            return (service:service,artist:nil)
        }
        if RESULT_ARTIST == section {
            print("sectipnm aa \(searchArtistList.count)")
            artist = searchArtistList[indexPath.item]
            return (service:nil,artist:artist)
        }
        return (service:nil,artist:nil)
        
    }
    
    func didSelectItem(section: Int, indexPath: IndexPath) {
        if ALL_SERVICE == section {
            if searchTextViewModel != "" {
                print("service : \(allServiceList[indexPath.item])")
                let id = allServiceList[indexPath.item].id
                self.fetchSearchArtistServiFilter(searchText: searchTextViewModel, serviceId: id)
            }else{
                // There here will add the alert
                print("Please enter search text")
            }
            
            
        }
        
        if RESULT_ARTIST == section {
            let vc = ArtistDetailViewController()
            vc.artistId = searchArtistList[indexPath.row].id
            view?.pushViewControllerable(vc, identifier: "ArtistDetailViewControllerIdentifier")
        }
    }
    
    
    
}

