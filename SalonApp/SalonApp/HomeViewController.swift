//
//  ViewController.swift
//  SalonApp
//
//  Created by engin gülek on 21.07.2023.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {

    private lazy var headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 4 ))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(headerView)
    
        
    }
    
    
    private func configureConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            
            
        }
    }
}

