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
    private var bookMarkListIdList : [BookMarkList] = []
    
  
    
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
    
    /*func fetchookMarkListId(){
        servisManager.fetchbookMarkListId(userId: 1) { response in
            switch response {
            case .success(let list):
                self.bookMarkListIdList = list ?? []
                self.view?.reloadDataTableView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }*/
    
    /*func fetchAddBookMarkList(userId:Int,artistId:Int){
        servisManager.fetchAddArtistToBookMarkList(userId: 1, artistId: artistId)
        self.view?.reloadDataTableView()
       
    }*/
    
    /*func deleteArtistFromBookMarkList(id:Int){
        servisManager.deleteArtistFromBookMarkList(id: id)
    }*/
}

extension HomeViewModel : HomeViewModelInterface{
    func viewDidLoad() {
        view?.indicatoViewTopArtist(animate: true)
        Task {
            @MainActor in
            self.fetchTopArtists()
            //self.fetchookMarkListId()
        }
        
        view?.setBackgroundColor("backColor")
        view?.prepareTableView()
         
    }
    
    func viewWillAppear() {
        view?.indicatoViewTopArtist(animate: true)
        Task {
            @MainActor in
            self.fetchTopArtists()
           // self.fetchookMarkListId()
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
        if bookMarkListIdList.contains(where: {$0.artist_id == topArtist.id}) {
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
        let artistId = topArtistList[item].id
        
      /*  Task {
            @MainActor in
           // self.fetchookMarkListId()
        }
        
        if bookMarkListIdList.contains(where: {$0.artist_id ==  artistId}) {
            Task {
                @MainActor in
               let info = bookMarkListIdList.filter {
                    $0.artist_id == artistId && $0.user_id == 1
               }.first
                self.deleteArtistFromBookMarkList(id:info!.id)
            }
           
        }else{
            Task{
                @MainActor in
                self.fetchAddBookMarkList(userId:1,artistId:artistId)
            }
        }*/
    }
}



