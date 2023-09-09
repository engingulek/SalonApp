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
    func bookMarkTapIcon(item:Int)
    
}

final class HomeViewModel  {
    private weak var view: HomeViewInterface?
    private let servisManager : HomePageServiceInterface
    private var topArtistList : [TopArtist] = []
    private var bookMarkListArtist : [BookMarkListArtist] = []
    
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
    
    func fetchookMarkListArtist(){
        Task {
            @MainActor in
            servisManager.fetchBookMarkList(userId: 1) { response in
                switch response {
                case .success(let list):
                    self.bookMarkListArtist = list ?? []
                    self.view?.reloadDataTableView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    func addArtistToBookMarkList(userId:Int,artistId:Int)  {
        let params = ["user_id" : userId,"artist_id":artistId]
        Task {
            @MainActor in
            servisManager.addArtistToBookMarkList(parameters: params) { response in
                switch response {
                case .success:
                    self.view?.reloadDataTableView()
                case .failure(let failure):
                    print("Add Home View Model Failure \(failure.localizedDescription)")
                }
            }
        }
       
    }
    
    func deleteArtistToBookMarkList(id:Int) {
        Task {
            @MainActor in
            servisManager.deleteArtistToBookMarkList(id: id) { response in
                switch response {
                case .success:
                    self.view?.reloadDataTableView()
                case .failure(let failure):
                    print("delete Home View Model Failure \(failure.localizedDescription)")
                }
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
            self.fetchookMarkListArtist()
        }
        
        view?.setBackgroundColor("backColor")
        view?.prepareTableView()
         
    }
    
    func viewWillAppear() {
        view?.indicatoViewTopArtist(animate: true)
        Task {
            @MainActor in
            self.fetchTopArtists()
            self.fetchookMarkListArtist()
        }
        view?.prepareTableView()
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
        iconType = ""
        if bookMarkListArtist.contains(where: {$0.artistId == topArtist.id}){
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
    
    func bookMarkTapIcon(item: Int) {
        
        self.fetchookMarkListArtist()
        let artistId = topArtistList[item].id
        let info = bookMarkListArtist.filter {
            $0.artistId == artistId && $0.userId == 1
        }.first
        
        if bookMarkListArtist.contains(where: {$0.artistId == artistId}) {
            
            if let id = info?.id {
                self.deleteArtistToBookMarkList(id:id)
            }
            
        }else{ self.addArtistToBookMarkList(userId:1,artistId:artistId) }
    }
}



