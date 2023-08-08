//
//  MainTabbarViewController.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: ChatListViewController())
        let vc3 = UINavigationController(rootViewController: BookMarkViewController())
        let vc4 = UINavigationController(rootViewController: ProfileViewController())
        self.tabBar.tintColor = .black
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        vc2.tabBarItem.image = UIImage(systemName: "message")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "message.fill")
        
        vc3.tabBarItem.image = UIImage(systemName: "bookmark")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")
        
        vc4.tabBarItem.image = UIImage(systemName: "person")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        
        
        setViewControllers([vc1,vc2,vc3,vc4] ,animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
