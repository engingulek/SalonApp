//
//  ArtistDetailViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 28.08.2023.
//

import Foundation

protocol ArtistDetailViewModelInterface{
    var sectionType : SectionTabs { get }
    func viewDidLoad()
    func sendMessageButtonTap()
    func didTapTab(selectLabel:String)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(at indexPath:IndexPath) -> (comment:Comment,backColor:String,borderColor:String)
}

final class ArtistDetailViewModel{
    private weak var view : ArtistDetailViewInterface?
    private var selectionString : String = "About"
    private var selectedTab : Int = 0
    init(view: ArtistDetailViewInterface) {
        self.view = view
    }
}


extension ArtistDetailViewModel : ArtistDetailViewModelInterface {

    var sectionType: SectionTabs {
        selectionString == "About" ? .about : .comment
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.prepareTabbarHidden(isHidden: true)
        view?.prepareNavigationBarCollor(colorText: "black")
    }
    
    func sendMessageButtonTap() {
        let vc = ChatViewController()
        view?.pushViewControllerable(vc, identifier: "ChatViewController")
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
