//
//  ArtistDetailViewController.swift
//  SalonApp
//
//  Created by engin gülek on 23.07.2023.
//

import UIKit
import SnapKit

protocol ArtistDetailViewInterface : AnyObject,ViewAble,NavigaitonBarAble,SeguePerformable {
    
    func prepareTableView()
    func prepareTabbarHidden(isHidden:Bool)
    func prepareSection(aboutisHidden:Bool,commetisHidden:Bool)
    func reloadDataTableView()
    func getArtistDetail()
    func indicatorView(animate:Bool)
    
}

 enum SectionTabs : String {
    case about = "About"
    case comment = "Comment"
}

class ArtistDetailViewController: UIViewController {
    
    private lazy var headerView = ArtistDetailView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 3 ))

    var artistId : Int?
    private lazy var viewModel = ArtistDetailViewModel(view: self)
    private let indicator: UIActivityIndicatorView = .init()
    private var tabs: [UIButton] = ["About","Comment"]
        .map { buttonTitle in
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.tintColor = .label
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
  
    private let sendMessageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private let textViewAbout : UITextView = {
        let textView = UITextView()
       
        textView.textAlignment = NSTextAlignment.natural
        textView.textColor = UIColor.black
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = UIColor(named: "backColor")
        textView.isHidden = false
        return textView
    }()
    
    private let commentTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = artistId else {return }
        
        sendMessageButton.addTarget(self, action: #selector(didTapSedMesseaga(_:)), for: .touchUpInside)
        configureStackButton()
        configureContraints()
        viewModel.viewDidLoad(artistId: id)
    }
    
   

    private func configureContraints(){
        
        view.addSubview(headerView)
        view.addSubview(sendMessageButton)
        view.addSubview(textViewAbout)
        view.addSubview(commentTableView)
        view.addSubview(sectionStack)
        view.addSubview(indicator)

        
        sectionStack.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
            
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.height.equalTo(35)
        }
        
        sendMessageButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.height.equalTo(50)
        }
        
        textViewAbout.snp.makeConstraints { make in
            make.top.equalTo(sectionStack.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.bottom.equalTo(sendMessageButton.snp.top).offset(-10)
        }
        
     
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(sectionStack.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.bottom.equalTo(sendMessageButton.snp.top).offset(-10)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    
    @objc private func didTapSedMesseaga(_ sender : UIButton){
        viewModel.sendMessageButtonTap()
    }
    
    // MARK: - Will change tab text color  when select tab
    private func configureStackButton() {
        for (_, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
        button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Select Tap
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text,let artistId = artistId else { return }
        viewModel.didTapTab(selectLabel: label,artistId: artistId)
    }
}

extension ArtistDetailViewController : ArtistDetailViewInterface {


    func prepareTableView() {
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.reloadData()
    }
    
    func prepareTabbarHidden(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    func reloadDataTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.commentTableView.reloadData()
        }
    }
    
    func prepareSection(aboutisHidden: Bool, commetisHidden: Bool) {
        textViewAbout.isHidden = aboutisHidden
        commentTableView.isHidden = commetisHidden
    }
    
    func getArtistDetail() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            headerView.configureData(artistDetail: viewModel.artistDetail!)
            self.textViewAbout.text = viewModel.artistDetail?.about
        }
    }
    
    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in

                   guard let self = self else { return }
                   animate ? self.indicator.startAnimating() : self.indicator.stopAnimating()
                   self.indicator.isHidden = !animate
               }
    }
}

extension ArtistDetailViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if tableView == self.commentTableView {
            guard let cell = commentTableView.dequeueReusableCell(
                withIdentifier: CommentTableViewCell.identifier,
                for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
            
             let item = viewModel.cellForRowAt(at: indexPath)
             cell.backgroundColor = UIColor(named: item.backColor)
             cell.layer.borderColor = UIColor(named: item.borderColor)?.cgColor
             cell
                 .configureData(comment: item.comment)
             cell.selectionStyle = .none
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    
}
