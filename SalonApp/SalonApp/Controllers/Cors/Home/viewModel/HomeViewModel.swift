//
//  HomeViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import UIKit
import Combine
protocol HomeViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func textFieldDidChange(_ text:String)
    func didSelectRow(at indexPath:IndexPath)
    func numberOfItemsInSection() -> Int
    func cellForItemAt(at indexPath:IndexPath) -> (topService:TopService,backColor:String,boderColor:String)
    func cellForRowAt(at indexPath:IndexPath) -> (topArtist:TopArtist,Void)
    func numberOfRowsInSection() -> Int
    
}

final class HomeViewModel  {
    private weak var view: HomeViewInterface?
    private let servisManager : HomePageServiceInterface
    init(view: HomeViewInterface,servisManager: HomePageServiceInterface = HomePageService.shared) {
        self.view = view
        self.servisManager = servisManager
    }
    
    private func fetchTopServices() async  {
        await servisManager.fetchTopServices { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    private func fetchTopArtists() async {
        await servisManager.fetchTopArtists { [weak self] in
            self?.view?.reloadData()
        }
    }
}

extension HomeViewModel : HomeViewModelInterface{
 
    
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        view?.prepareTableView()
        Task {
            @MainActor in
            await self.fetchTopServices()
            await self.fetchTopArtists()
        }
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
    
    
    func cellForItemAt(at indexPath: IndexPath) -> (topService:TopService,backColor:String,boderColor:String) {
        var backgroundColor : String
        var borderColor : String
        var topService : TopService
        backgroundColor =  "backColor"
        borderColor = "backColor"
        if servisManager.topServices.count != 0 {
            topService = servisManager.topServices[indexPath.item]
        }else{
            topService = .init(id: 0, imageUrl: "", name: "")
        }
      
        
        return (topService:topService,backColor:backgroundColor,boderColor:borderColor)
    }
    
    func numberOfItemsInSection() -> Int {
        return servisManager.topServices.count
    }
    
   
    
    
    func cellForRowAt(at indexPath: IndexPath) -> (topArtist: TopArtist, Void) {
        
        
        var topArtist : TopArtist
        if servisManager.topArtists.count != 0 {
            topArtist =  servisManager.topArtists[indexPath.row]
        }else{
            topArtist =  .init(id: 0, imageUrl: "", rating: 0.0 ,name: "", bestService: "", locationcity: "",pay: 0.0)
        }
     
        return (topArtist,())
    }
    
    func numberOfRowsInSection() -> Int {
        return servisManager.topArtists.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        vc.artistId = servisManager.topArtists[indexPath.row].id
        view?.pushViewControllerable(vc, identifier: "ArtistDetailViewControllerIdentifier")
    }
}



