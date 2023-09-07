//
//  HomeViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var selectedTopServiceIndex: IndexPath {get set}
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func textFieldDidChange(_ text:String)
    func didSelectRow(at indexPath:IndexPath)
    func cellForRowAt(at indexPath:IndexPath) -> (topArtist:TopArtist,Void)
    func numberOfRowsInSection() -> Int
    
}

final class HomeViewModel  {
    private weak var view: HomeViewInterface?
    private let servisManager : HomePageServiceInterface
    var selectedTopServiceIndex:IndexPath = [0,0]
    private var topServiceList: [TopService] = []
     var topArtistList : [TopArtist] = []
  
    
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
                print("Denemelik \(failure.localizedDescription)")
            }
             self.view?.indicatoViewTopArtist(animate: false)
        })
    }
}

extension HomeViewModel : HomeViewModelInterface{
    
    func viewDidLoad() {
        view?.indicatoViewTopArtist(animate: true)
        Task {
            @MainActor in
            self.fetchTopArtists()
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
    
    func numberOfItemsInSection() -> Int {
        return topServiceList.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        self.selectedTopServiceIndex = indexPath
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> (topArtist: TopArtist, Void) {
        var topArtist : TopArtist
        topArtist = topArtistList[indexPath.row]
        return (topArtist,())
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



