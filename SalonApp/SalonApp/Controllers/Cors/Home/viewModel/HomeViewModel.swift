//
//  HomeViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation

protocol HomeViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func textFieldDidChange(_ text:String)
    func didSelectRow(at indexPath:IndexPath)
    func cellForRowAt(at indexPath:IndexPath) -> (topArtist:TopArtist,iconType:String)
    func numberOfRowsInSection() -> Int
    
}

final class HomeViewModel  {
    private weak var view: HomeViewInterface?
    private let servisManager : HomePageServiceInterface
    private var topArtistList : [TopArtist] = []
    private var bookMarkListIdList : [Int] = []
    
  
    
    init(view: HomeViewInterface,servisManager: HomePageServiceInterface = HomePageService.shared) {
        self.view = view
        self.servisManager = servisManager
    }
    
     func fetchTopArtists() {
         servisManager.fetchTopArtists(completion: { response in
            switch response {
            case .success(let list):
                self.topArtistList = list ?? []
                self.view?.reloadDataTableView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
             self.view?.indicatoViewTopArtist(animate: false)
        })
    }
    
    func fetchookMarkListId(){
        servisManager.fetchbookMarkListId(userId: 1) { response in
            switch response {
            case .success(let list):
                self.bookMarkListIdList = list ?? []
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension HomeViewModel : HomeViewModelInterface{
   
    
    
    func viewDidLoad() {
        view?.indicatoViewTopArtist(animate: true)
        Task {
            @MainActor in
            self.fetchTopArtists()
            self.fetchookMarkListId()
        }
        
        view?.setBackgroundColor("backColor")
        view?.prepareTableView()
         
    }
    
    func viewWillAppear() {
        view?.prepareTabbarHidden(isHidden: false)
    }
    
    func viewWillDisappear() {
        view?.prepareTextFieldController(text: "")
      
    }
    
    func textFieldDidChange(_ text: String) {
        guard text == text else {return}
        if text.count == 3 {
            let vc = SearchViewController()
            vc.searchText = text
           // vc.getSearchText(searchText: text)
            view?.pushViewControllerable(vc, identifier: "SearchViewControllerIdentifier")
        }
    }
    
   
    
   
    
    func cellForRowAt(at indexPath: IndexPath) -> (topArtist: TopArtist, iconType:String) {
        var topArtist : TopArtist
        var iconType : String
        topArtist = topArtistList[indexPath.row]
        if bookMarkListIdList.contains(topArtist.id){
            iconType = "bookmark.fill"
        }else{
            iconType = "bookmark"
        }
        return (topArtist,iconType)
    }
    
    func numberOfRowsInSection() -> Int {
        return topArtistList.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        vc.artistId = topArtistList[indexPath.row].id
        view?.pushViewControllerable(vc, identifier: "ArtistDetailViewControllerIdentifier")
    }
    
    
}



