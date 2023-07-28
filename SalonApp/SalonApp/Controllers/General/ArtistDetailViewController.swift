//
//  ArtistDetailViewController.swift
//  SalonApp
//
//  Created by engin gülek on 23.07.2023.
//

import UIKit
import SnapKit
class ArtistDetailViewController: UIViewController {
    private enum SectionTabs : String {
        case about = "About"
        case services = "Services"
        case comment = "Comment"
    }
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
  
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
          return view
      }()
    
    private var selectedTab: Int = 0 {
        didSet {
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseOut) { [weak self] in
                    self?.sectionStack.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ?  true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ?  true : false
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }

    private var tabs: [UIButton] = ["About", "Services", "Comment"]
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
    private let bookAppointmentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Book Appointment", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    
    private let sendMessageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Message", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let textViewAbout : UITextView = {
        let textView = UITextView()
       
        textView.textAlignment = NSTextAlignment.natural
        textView.textColor = UIColor.black
        textView.font = .systemFont(ofSize: 18)
        textView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic "
        textView.backgroundColor = UIColor(named: "backColor")
        textView.isHidden = false
        return textView
    }()
    
    private let serviceTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ArtistServiceTableViewCell.self, forCellReuseIdentifier: ArtistServiceTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        return tableView
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
    
    private lazy var headerView = ArtistDetailView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.layer.frame.height / 3 ))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerView)
        view.backgroundColor = UIColor(named: "backColor")
        view.addSubview(sectionStack)
        view.addSubview(indicator)
        view.addSubview(bookAppointmentButton)
        view.addSubview(sendMessageButton)
        view.addSubview(textViewAbout)
        view.addSubview(serviceTableView)
        view.addSubview(commentTableView)
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.black
        tabBarController?.tabBar.isHidden = true
        sendMessageButton.addTarget(self, action: #selector(didTapSedMesseaga(_:)), for: .touchUpInside)
        configureStackButton()
        configureContraints()
    }

    private func configureContraints(){
        for i in 0..<tabs.count {
                   let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
                   leadingAnchors.append(leadingAnchor)
                   let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
                   trailingAnchors.append(trailingAnchor)
               }
        
        sectionStack.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
            
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.top.equalTo(headerView.snp.bottom).offset(5)
            make.height.equalTo(35)
        }
        bookAppointmentButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(self.sendMessageButton.snp.top).offset(-5)
            make.height.equalTo(50)
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
            make.bottom.equalTo(bookAppointmentButton.snp.top).offset(-10)
        }
        
        serviceTableView.snp.makeConstraints { make in
            make.top.equalTo(sectionStack.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.bottom.equalTo(bookAppointmentButton.snp.top).offset(-10)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(sectionStack.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(25)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.bottom.equalTo(bookAppointmentButton.snp.top).offset(-10)
        }
        
    // Used UIKit to select About when selecting Detail Page
            let indicatorConstraints = [
                leadingAnchors[0],
                trailingAnchors[0],
                indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
                indicator.heightAnchor.constraint(equalToConstant: 4)
            ]
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    
    
    @objc private func didTapSedMesseaga(_ sender : UIButton){
        let chatVC = ChatViewController()
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    // MARK: - Will change tab text color  when select tab
    private func configureStackButton() {
        for (i, button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            if i == selectedTab {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
        button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Select Tap
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return }
        switch label {
        case SectionTabs.about.rawValue:
            selectedTab = 0
            textViewAbout.isHidden = false
            serviceTableView.isHidden = true
            commentTableView.isHidden = true
        case SectionTabs.services.rawValue:
            selectedTab = 1
            textViewAbout.isHidden = true
            serviceTableView.isHidden = false
            commentTableView.isHidden = true
        case SectionTabs.comment.rawValue:
            selectedTab = 2
            textViewAbout.isHidden = true
            serviceTableView.isHidden = true
            commentTableView.isHidden = false
        default:
            selectedTab = 0
            textViewAbout.isHidden = false
            serviceTableView.isHidden = true
            commentTableView.isHidden = true
        }
    }
}

extension ArtistDetailViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.serviceTableView {
            guard let cell = serviceTableView.dequeueReusableCell(withIdentifier: ArtistServiceTableViewCell.identifier,
                                                                    for: indexPath) as? ArtistServiceTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }
        else if tableView == self.commentTableView {
            guard let cell = commentTableView.dequeueReusableCell(
                withIdentifier: CommentTableViewCell.identifier,
                for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    
}
