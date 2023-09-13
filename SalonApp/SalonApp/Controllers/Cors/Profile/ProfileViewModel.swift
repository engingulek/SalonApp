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
    func updateProfile(imageUrl:String,name:String,surname:String,email:String,currentPass:String,newPass:String)
    func logout()
}

private let appDelegate = UIApplication.shared.delegate as! AppDelegate

final class ProfileViewModel : ProfileViewModelInterface {
    private var userInfo : [UserInfo] = []
    private let context = appDelegate.persistentContainer.viewContext
    private weak var view : ProfileViewInterface?
    private var serviceManager : ProfileServiceInterdace?
    
    init(view: ProfileViewInterface,serviceManager: ProfileServiceInterdace = ProfileService.shared) {
        self.view = view
        self.serviceManager = serviceManager
      
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
        }
    }
    
    private func updateUser(id:Int,imageUrl:String,name:String,surname:String,email:String,currentPass:String,newPass:String){
        let params:[String:Any] = ["id":id,"name":name,"surname":surname,"email":email,"password":currentPass,"newPassword":newPass]
        view?.indicatoView(animate: true)
        serviceManager?.updateProfile(parameters: params, completion: { result in
            switch result {
            case .success:
                self.view?.indicatoView(animate: false)
            case .failure: break
            }
            self.view?.indicatoView(animate: false)
        })
    }
    

    func updateProfile(imageUrl:String,name:String,surname:String,email:String,currentPass:String,newPass:String) {
        updateUser(id: Int(userInfo[0].id), imageUrl: imageUrl,
                   name: name, surname: surname,
                   email: email, currentPass: currentPass,
                   newPass: newPass)
    }
    
    func logout() {
        let user = userInfo[0]
        context.delete(user)
        appDelegate.saveContext()
        self.view?.tabbarSelectedIndex(at: 0)
    }
    
}
