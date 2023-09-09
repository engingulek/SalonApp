//
//  BookMarkListViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 8.09.2023.
//

import Foundation

protocol BookMarkListViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(at indexPath:IndexPath) -> (artist:BookMarkListArtist,iconType:String)
    func didSelectItem(at indexPath:IndexPath)
    func trashTapIcon(row:Int)
}

final class BookMarkListViewModel {
    private weak var view : BookMarkViewInterface?
    private let serviceManager : BookMarkListServiceInterface
    private var bookMarkList : [BookMarkListArtist] = []
    
    init(view: BookMarkViewInterface, serviceManager: BookMarkListServiceInterface = BookMarkListService.shared) {
        self.view = view
        self.serviceManager = serviceManager
    }
    
    func fetchBookMarkList() {
        serviceManager.fetchBookMarkList(userId: 1) { response in
            switch response {
            case .success(let list):
                self.bookMarkList = list ?? []
                if self.bookMarkList.isEmpty {
                    self.view?.emptyBookMarkList(message: "Bookmark List is Empty", isHidden:true)
                }else{
                    self.view?.emptyBookMarkList(message: "", isHidden:false)
                }
                self.view?.reloadDataTableView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            self.view?.indicator(animate: false)
        }
    }
    
    func deleteArtistFromBookMarkList(id:Int) {
        Task {
            @MainActor in
            serviceManager.deleteArtistToBookMarkList(id: id) { response in
                switch response {
                case .success:
                    self.view?.reloadDataTableView()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
}

extension BookMarkListViewModel : BookMarkListViewModelInterface {
   
    
    func viewDidLoad() {
        view?.indicator(animate: true)
        Task {
            @MainActor in
            self.fetchBookMarkList()
        }
        view?.setBackgroundColor("backColor")
        view?.navigationItemTitle(title: "Book Mark List")
        view?.prepareTableView()
    }
    
    func viewWillAppear() {
        view?.indicator(animate: true)
        Task {
            @MainActor in
            self.fetchBookMarkList()
        }
        view?.prepareTableView()
        view?.prepareTabbarHidden(isHidden: false)
    }
    
    func numberOfRowsInSection() -> Int {
        return bookMarkList.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> (artist: BookMarkListArtist, iconType:String) {
        var artist : BookMarkListArtist
        artist = bookMarkList[indexPath.row]
        return (artist:artist,iconType:"trash.fill")
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        vc.artistId = bookMarkList[indexPath.row].artistId
        view?.pushViewControllerable(vc, identifier: "ArtistDetailViewControllerIdentifier")
    }
    
    func trashTapIcon(row: Int) {
        let id = bookMarkList[row].id
        self.deleteArtistFromBookMarkList(id: id)
        self.fetchBookMarkList()
    }
    
    
}
