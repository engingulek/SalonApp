//
//  AllServiceTableViewCellViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 2.09.2023.
//

import Foundation

protocol AllServiceTableViewCellViewModelInterface {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func cellForItemAt(at indexPath:IndexPath) -> (service:AllService,textColor:String)
    func didSelectItemAt(at indexPath:IndexPath) -> (textColor:String,selectedTextColor:String)
    func changeLastSelected(at indexPath:IndexPath)
}


final class AllServiceTableViewCellViewModel {
    private weak var view :AllServiceTableViewCellInterface?
    private let serviceManager : SearchServiceInterface?
    var allServiceList : [AllService] = []
    private var selectSerice : IndexPath = [0,0]
    init(view: AllServiceTableViewCellInterface,serviceManager: SearchService = SearchService.shared) {
        self.view = view
        self.serviceManager = serviceManager
    }
    
    func fetchAllService(){
        serviceManager?.fetchAllService(completion: { response in
            switch response {
            case .success(let list):
                self.allServiceList = list ?? []
                self.view?.reloadDataColletionView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            self.view?.indicatoView(animate: false)
        })
    }
}

extension AllServiceTableViewCellViewModel: AllServiceTableViewCellViewModelInterface {
    
    var selectedService : IndexPath {
        selectSerice
    }
    
    func viewDidLoad() {
        view?.indicatoView(animate: true)
        Task {
            @MainActor in
            self.fetchAllService()
        }
        view?.prepareCollectionView()
    }
    
    func numberOfItemsInSection() -> Int {
        return allServiceList.count
    }
    
    func cellForItemAt(at indexPath: IndexPath) -> (service:AllService,textColor:String) {
        let service:AllService
        var textColor:String
        service = allServiceList[indexPath.item]
        textColor = "back"
        if selectedService == indexPath {
            textColor = "allServiceSelected"
        }
        return (service:service,textColor:textColor)
    }
    
    func didSelectItemAt(at indexPath: IndexPath) -> (textColor:String,selectedTextColor:String) {
        
        let textColor:String
        let selectedTextColor:String
        textColor = "back"
        selectedTextColor = "allServiceSelected"
        return (textColor:textColor,selectedTextColor:selectedTextColor)
     
    }
    
    func changeLastSelected(at indexPath: IndexPath) {
        selectSerice = indexPath
    }
    
    
    
}
