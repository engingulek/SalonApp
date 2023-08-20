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
    var view:HomeViewInterface? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func textFieldDidChange(_ textField: UITextField)
    func didSelectRow(at indexPath:IndexPath)
    func cellForItemAt(at indexPath:IndexPath) -> (topService:TopService,backColor:String,boderColor:String)
    
}

final class HomeViewModel  {
    weak var view: HomeViewInterface?
    private func fetchTopServices() async  {
        await HomePageService.shared.fetchTopServices { [weak self] in
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
        }
    }
    
    func viewWillAppear() {
        view?.prepareTabbarHidden()
    }
    
    func viewWillDisappear() {
        view?.prepareTextFieldController()
      
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if text.count == 3 {
            view?.toSearchViewController()
        }
    }
    
    
    func cellForItemAt(at indexPath: IndexPath) -> (topService:TopService,backColor:String,boderColor:String) {
        var backgroundColor : String
        var borderColor : String
        var topService : TopService
        backgroundColor =  "backColor"
        borderColor = "backColor"
        if HomePageService.shared.topServices.count != 0 {
            topService = HomePageService.shared.topServices[indexPath.row]
        }else{
            topService = .init(id: 0, imageUrl: "", name: "")
        }
      
        
        return (topService:topService,backColor:backgroundColor,boderColor:borderColor)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        view?.pushViewControllerable(vc)
    }
}



