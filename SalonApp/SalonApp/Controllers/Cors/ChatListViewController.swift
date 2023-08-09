//
//  ChatListViewController.swift
//  SalonApp
//
//  Created by engin gülek on 28.07.2023.
//

import UIKit
import SnapKit
class ChatListViewController: UIViewController {
    private let chatListTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: ChatListTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  .black
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(chatListTableView)
        self.navigationItem.title = "Chat List"
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        configureConstraints()
    }
    
    private func configureConstraints() {
        chatListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension ChatListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == chatListTableView {
            guard let cell = chatListTableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier,for: indexPath) as? ChatListTableViewCell else {return UITableViewCell()}
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    
}
