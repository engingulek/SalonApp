//
//  ArtistDetailViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation

protocol ArtistDetailViewModelInterface{
    //var sectionType : SectionTabs { get }
    func viewDidLoad(artistId:Int)
    func didTapTab(selectLabel:String,artistId:Int)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(at indexPath:IndexPath) -> (comment:Comment,backColor:String,borderColor:String)
  
}

final class ArtistDetailViewModel{
    private weak var view : ArtistDetailViewInterface?
    private let serviceManager : ArtistDetailServiceInterfece
    private var selectionString : String = "About"
    private var selectedTab : Int = 0
    var artistDetail : ArtistDetail? = nil
    var artistComment : [Comment] = []
   
    
    init(view: ArtistDetailViewInterface,serviceManager: ArtistDetailServiceInterfece = ArtistDetailService.shared) {
        self.view = view
        self.serviceManager = serviceManager
    }
    
    func fetchArtistDetail(artistId:Int) {
       serviceManager.fetchArtistDetail(artistId: artistId) { response in
            switch response {
            case .success(let success):
                self.artistDetail = success![0]
                self.view?.getArtistDetail()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
  
    func fetchArtistComment(artistId:Int){
        serviceManager.fetchArtistComment(artisId: artistId) { response in
            switch response {
            case .success(let success):
                self.artistComment = success ?? []
                self.view?.reloadDataTableView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            self.view?.indicatorView(animate: false)
        }
    }
}


extension ArtistDetailViewModel : ArtistDetailViewModelInterface {
    var sectionType: SectionTabs {
        selectionString == "About" ? .about : .comment
    }
    
    func viewDidLoad(artistId:Int)  {
        view?.indicatorView(animate: true)
        Task {
            @MainActor in
            self.fetchArtistDetail(artistId:artistId)
        }
       
        view?.prepareTableView()
        view?.prepareTabbarHidden(isHidden: true)
        view?.prepareNavigationBarCollor(colorText: "black")
        view?.setBackgroundColor("backColor")
        view?.navigationItemTitle(title: "Artist Detail")
    }
    
    
    
 
    func didTapTab(selectLabel:String,artistId:Int) {
        selectionString = selectLabel
        switch sectionType {
        case .about:
            view?.prepareSection(aboutisHidden: false, commetisHidden: true)
        case .comment:
            view?.prepareSection(aboutisHidden: true, commetisHidden: false)
            self.fetchArtistComment(artistId: artistId)
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return self.artistComment.count
    }
    
    func cellForRowAt(at indexPath:IndexPath) -> (comment: Comment, backColor: String, borderColor: String) {
        var comment : Comment
        var backColor:String
        var borderColor:String
        
        backColor = "backColor"
        borderColor = "backColor"
        comment  = self.artistComment[indexPath.row]
        
        return (comment:comment,backColor:backColor,borderColor:borderColor)
    }
}
