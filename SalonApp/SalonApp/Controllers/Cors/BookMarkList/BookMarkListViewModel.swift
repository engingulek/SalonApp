//
//  BookMarkListViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 8.09.2023.
//

import Foundation
import UIKit.UIApplication
protocol BookMarkListViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(at indexPath:IndexPath) -> (artist:BookMarkListArtist,iconType:String)
    func didSelectItem(at indexPath:IndexPath)
    func trashTapIcon(row:Int)
}

private let appDelegate = UIApplication.shared.delegate as! AppDelegate
final class BookMarkListViewModel {
    private let context = appDelegate.persistentContainer.viewContext
    
    private weak var view : BookMarkViewInterface?
    private let serviceManager : BookMarkListServiceInterface
    private var bookMarkList : [BookMarkListArtist] = []
    private var userInfo : [UserInfo] = []
    
    init(view: BookMarkViewInterface, serviceManager: BookMarkListServiceInterface = BookMarkListService.shared) {
        self.view = view
        self.serviceManager = serviceManager
    }
    
    private func fetchUserInfo(){
         do{
             userInfo = try context.fetch(UserInfo.fetchRequest())
         }catch{
             view?.emptyBookMarkList(message: "Something went wrong", isHidden: false)
            
         }
     }
    
    func fetchBookMarkList() {
        fetchUserInfo()
        if userInfo.isEmpty {
            view?.emptyBookMarkList(message: "Please log in from profile", isHidden: true)
            self.view?.indicator(animate: false)
        }else{
            serviceManager.fetchBookMarkList(userId: Int(userInfo[0].id)) {[weak self] response in
                switch response {
                case .success(let list):
                    self?.bookMarkList = list ?? []
                    if ((self?.bookMarkList.isEmpty) != nil) {
                        self?.view?.emptyBookMarkList(message: "Bookmark List is Empty", isHidden:true)
                    }else{
                        self?.view?.emptyBookMarkList(message: "", isHidden:false)
                    }
                    self?.view?.reloadDataTableView()
                case .failure(let failure):
                    self?.view?.emptyBookMarkList(message: failure.localizedDescription, isHidden: true)
                }
                self?.view?.indicator(animate: false)
            }
        }
      
    }
    
    func deleteArtistFromBookMarkList(id:Int) {
        Task {
            @MainActor in
            serviceManager.deleteArtistToBookMarkList(id: id) { [weak self] response in
                switch response {
                case .success:
                    self?.view?.reloadDataTableView()
                case .failure(let failure):
                    self?.view?.emptyBookMarkList(message: failure.localizedDescription, isHidden: true)
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
