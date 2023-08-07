//
//  StroyViewController.swift
//  SalonApp
//
//  Created by engin gülek on 7.08.2023.
//

import UIKit
import SnapKit
class StroyViewController: UIViewController {
    var index : Int = 0
    var panGesture  = UIPanGestureRecognizer()
    private let storyImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "storyDefault")
        return imageView
        
    }()
    
    private let artistName : UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16,weight: .bold)
        return label
    }()
    
    
    private let storyTime :  UILabel = {
        let label = UILabel()
        label.text = "12s"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15,weight: .regular)
        return label
    }()
    
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "person")
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(storyImageView)
        storyImageView.addSubview(artistName)
        storyImageView.addSubview(profileAvatarImageView)
        storyImageView.addSubview(storyTime)
        navigationController?.navigationBar.isHidden = true
        configureContraints()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragImg(_:)))
        storyImageView.isUserInteractionEnabled = true
        storyImageView.addGestureRecognizer(panGesture)        
    }
    
    @objc func dragImg(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        
        if translation.y > 0 {
            storyImageView.center = CGPoint(x: storyImageView.center.x, y: storyImageView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            if storyImageView.frame.height < storyImageView.center.y + translation.y {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func configureContraints() {
        storyImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        profileAvatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        artistName.snp.makeConstraints { make in
            make.centerY.equalTo(profileAvatarImageView.snp.centerY)
            make.leading.equalTo(profileAvatarImageView.snp.trailing).offset(10)
        }
        storyTime.snp.makeConstraints { make in
            make.centerY.equalTo(profileAvatarImageView.snp.centerY)
            make.leading.equalTo(artistName.snp.trailing).offset(10)
            
        }
    }
}
