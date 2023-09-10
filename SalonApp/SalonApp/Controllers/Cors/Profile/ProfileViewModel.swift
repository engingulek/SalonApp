//
//  ProfileViewModel.swift
//  SalonApp
//
//  Created by engin gülek on 10.09.2023.
//

import Foundation
import UIKit.UIApplication

protocol ProfileViewModelInterface{
    func viewDidLoad()
    func viewWillAppear()
}

private let appDelegate = UIApplication.shared.delegate as! AppDelegate

final class ProfileViewModel : ProfileViewModelInterface {
    private var userInfo : [UserInfo] = []
    private let context = appDelegate.persistentContainer.viewContext
    private weak var view : ProfileViewInterface?
    
    init(view: ProfileViewInterface) {
        self.view = view
    }
    
    
    func viewDidLoad() {
        view?.setBackgroundColor("backColor")
        view?.navigationItemTitle(title: "Profil")
        view?.prepareTabbarHidden(isHidden: false)
        fetchUserInfo()
    }
    
    func viewWillAppear() {
        fetchUserInfo()
        view?.prepareTabbarHidden(isHidden: false)
    }
    
   private func fetchUserInfo(){
        do{
            userInfo = try context.fetch(UserInfo.fetchRequest())
            if userInfo.isEmpty {
               view?.userInfoData(userInfo: nil, isHidden: true)
            }else{
                view?.userInfoData(userInfo: userInfo, isHidden: false)
            }
        }catch{
            view?.userInfoData(userInfo: nil, isHidden: true)
            print("Veri okurken hata oluştu")
        }
    }
}
