//
//  SeguePerformable.swift
//  SalonApp
//
//  Created by engin gülek on 20.08.2023.
//

import UIKit

protocol SeguePerformable {

    func pushViewControllerable(_ vc:UIViewController,identifier:String)
}

extension SeguePerformable where Self:UIViewController {
    func pushViewControllerable(_ vc:UIViewController,identifier:String){
        navigationController?.pushViewController(vc, animated: true)
    }
}
