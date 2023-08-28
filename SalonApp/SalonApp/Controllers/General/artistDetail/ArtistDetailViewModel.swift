//
//  ArtistDetailViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation

protocol ArtistDetailViewModelInterface{
    var sectionType : SectionTabs { get }
    func viewDidLoad(artistId:Int)
    func sendMessageButtonTap()
    func didTapTab(selectLabel:String)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(at indexPath:IndexPath) -> (comment:Comment,backColor:String,borderColor:String)
  
}

final class ArtistDetailViewModel{
    private weak var view : ArtistDetailViewInterface?
    private let serviceManager : ArtistDetailServiceInterfece
    private var selectionString : String = "About"
    private var selectedTab : Int = 0
    var artistDetail : ArtistDetail? = nil
    
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
}


extension ArtistDetailViewModel : ArtistDetailViewModelInterface {
    var sectionType: SectionTabs {
        selectionString == "About" ? .about : .comment
    }
    
    func viewDidLoad(artistId:Int)  {
        self.fetchArtistDetail(artistId:artistId)
        view?.prepareTableView()
        view?.prepareTabbarHidden(isHidden: true)
        view?.prepareNavigationBarCollor(colorText: "black")
    }
    
    func sendMessageButtonTap() {
        let vc = ChatViewController()
        view?.pushViewControllerable(vc, identifier: "ChatViewControllerIndetifier")
    }
    
 
    func didTapTab(selectLabel:String) {
        selectionString = selectLabel
        switch sectionType {
        case .about:
            view?.prepareSection(aboutisHidden: false, commetisHidden: true)
        case .comment:
            view?.prepareSection(aboutisHidden: true, commetisHidden: false)
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return 3
    }
    
    func cellForRowAt(at indexPath:IndexPath) -> (comment: Comment, backColor: String, borderColor: String) {
        var comment : Comment
        var backColor:String
        var borderColor:String
        
        backColor = "backColor"
        borderColor = "backColor"
        comment  = .init(id: 0, nameSurname: "testName", comment: "testComment")
        
        return (comment:comment,backColor:backColor,borderColor:borderColor)
    }
}
