//
//  MainTabbarViewController.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit

final class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hvc = UINavigationController(rootViewController: HomeViewController())
     
        let bvc = UINavigationController(rootViewController: BookMarkViewController())
        let  pvc = UINavigationController(rootViewController: ProfileViewController())
        self.tabBar.tintColor = .black
        
        hvc.tabBarItem.image = UIImage(systemName: "house")
        hvc.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        bvc.tabBarItem.image = UIImage(systemName: "bookmark")
        bvc.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        
        pvc.tabBarItem.image = UIImage(systemName: "person")
        pvc.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        setViewControllers([hvc,bvc,pvc] ,animated: true)
        
    }
}
