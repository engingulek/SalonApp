//
//  BaseViewControllerProtocol.swift
//  SalonApp
//
//  Created by engin gülek on 31.08.2023.
//

import Foundation
import UIKit




protocol ViewAble {
    func setBackgroundColor(_ color: String)
}

extension ViewAble where Self : UIViewController{
    func setBackgroundColor(_ color: String) {
        view?.backgroundColor = UIColor(named: color)
    }
}

protocol SeguePerformable {
    func pushViewControllerable(_ vc:UIViewController,identifier:String)
}

extension SeguePerformable where Self : UIViewController {
    func pushViewControllerable(_ vc:UIViewController,identifier:String){
        navigationController?.pushViewController(vc, animated: true)
    }

}

protocol NavigaitonBarAble {
    func prepareNavigationBarCollor(colorText:String)
    func navigationItemTitle(title:String)
    func popViewControllerAble()
}

extension NavigaitonBarAble where Self : UIViewController{
    func prepareNavigationBarCollor(colorText: String) {
        self.navigationController?.navigationBar.tintColor = UIColor(named: colorText)
    }
    
    func popViewControllerAble(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationItemTitle(title:String){
        self.navigationItem.title = title
    }
}


