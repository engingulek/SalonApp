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

enum SortType : String {
    case priceDESC = "Price Descending"
    case priceASC = "Price Increasing"
    case hightRating = "Hight Rating"
    
    func toServiceType() -> String {
        switch self {
        case .priceDESC:
            return "DESC"
        case .priceASC:
            return "ASC"
        case .hightRating:
            return "HightRating"
        }
    }
}

protocol SearchViewModelInterface {
    func viewDidLoad(searchText:String)
    func numberOfSections() -> Int
    func numberOfItemsInSection(section:Int) -> Int
    func cellForItemAt(section:Int,indexPath:IndexPath) -> (service: AllService?, artist: TopArtist?)
    func didSelectItem(section:Int,indexPath:IndexPath)
    func searchAction(searchText:String)
    func searchArtistSort(sortType:SortType)
   
    
}

final class SearchViewModel {
   
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
                
                self.view?.reloadServiceSection()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchSearchArtist(searchText:String) {
        if !searchTextViewModel.isEmpty {
            serviceManager.fetchSearchArtist(searchText: searchText.lowercased()) { response in
                switch response {
                case .success(let list):
                    //self.searchArtistList = []
                    self.searchArtistList = list ?? []
                    if self.searchArtistList.isEmpty {
                        self.view?.searchDidNotComeData(message: "No product matching your search was found", icon: "no-data")
                    }
                    self.view?.reloadArtistSection()
                case .failure(let failure):
                    self.searchErrorHandler(error: failure)
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
                    print("Search View Model \(self.searchArtistList.count)")
                    print(searchText.lowercased())
                    self.view?.reloadArtistSection()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                
            }
        }
    }
    
    func fetchsearchArtistSort(sortType:SortType) {
        print("Fetch ViewModel \(sortType.toServiceType())")
        serviceManager.fetchSearchArtistSort(sortType: sortType, searchText: searchTextViewModel) { response in
            switch response {
            case .success(let list):
                self.searchArtistList = list ?? []
                self.view?.reloadArtistSection()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
   


}



extension SearchViewModel : SearchViewModelInterface  {
    
    
    func viewDidLoad(searchText:String) {
        Task {
            @MainActor in
            self.fetchAllService()
            self.fetchSearchArtist(searchText:searchText)
          
        }
      
        self.searchTextViewModel = searchText.lowercased()
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
    
    func searchArtistSort(sortType: SortType) {
        print("ViewModel \(sortType.toServiceType())")
        Task {
            @MainActor in
            self.fetchsearchArtistSort(sortType:sortType)
        }
       
    }
    
   private func searchErrorHandler(error:Error){
       if  CustomError.networkError == error as! CustomError {
           view?.onErrorSearch(message: "Page not found. Try again", icon: "error-404")
       }
       
       if CustomError.testError == error as! CustomError {
           view?.onErrorSearch(message: "Something went wrong.", icon: "cross")
       }
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

