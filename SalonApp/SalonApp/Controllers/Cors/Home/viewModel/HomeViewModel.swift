//
//  HomeViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import Foundation
import UIKit
protocol HomeViewModelInterface {
    var view:HomeViewInterface? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func textFieldDidChange(_ textField: UITextField)
    func didSelectRow(at indexPath:IndexPath)
    
}


final class HomeViewModel {
    weak var view: HomeViewInterface?
}

extension HomeViewModel : HomeViewModelInterface{
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        view?.prepareTableView()
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
    
    
    func didSelectRow(at indexPath: IndexPath) {
        let vc = ArtistDetailViewController()
        view?.pushViewControllerable(vc)
    }
    
    
    
}
