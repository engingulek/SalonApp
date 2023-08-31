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
    func didSelectItem(at indexPath:IndexPath )
    func numberOfItemsInSection() -> Int
    func cellForItemAt(at indexPath:IndexPath) -> (topService:TopService,backColor:String,cellSelectBackColor:String,boderColor:String)
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
    
      func fetchTopServices()   {
         servisManager.fetchTopServices(completion: { response in
            switch response {
            case .success(let list):
                self.topServiceList = list ?? []
                self.view?.reloadDataCollectionView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
             self.view?.indicatorViewTopService(animate: false)
        })
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
}

extension HomeViewModel : HomeViewModelInterface{
    
    func viewDidLoad() {
        view?.indicatorViewTopService(animate: true)
        view?.indicatoViewTopArtist(animate: true)
        Task {
            @MainActor in
            self.fetchTopServices()
            self.fetchTopArtists()
        }
        
        view?.setBackgroundColor("backColor")
        view?.prepareCollectionView()
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
            view?.pushViewControllerable(vc, identifier: "SearchViewControllerIdentifier")
        }
    }
    
    
    func cellForItemAt(at indexPath: IndexPath) -> (topService:TopService,
                                                    backColor:String,
                                                    cellSelectBackColor:String,
                                                    boderColor:String) {
        print("Testi \(indexPath.item)")
        print("Testi2 \(selectedTopServiceIndex.item)")
        var backgroundColor : String
        var borderColor : String
        var topService : TopService
        var selectBackColor: String
        
        backgroundColor =  "backColor"
        borderColor = "backColor"
        selectBackColor = "cellSelected"
        topService = topServiceList[indexPath.row]
       
        return (topService:topService,backColor:backgroundColor,cellSelectBackColor:selectBackColor,boderColor:borderColor)
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



