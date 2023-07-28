//
//  ChatViewController.swift
//  SalonApp
//
//  Created by engin gülek on 28.07.2023.
//

import UIKit
import SnapKit


struct TestMessage {
    let id:String
    let userId:String
    let userName:String
    let message:String
    
}

class ChatViewController: UIViewController {
    private lazy var chatTextView = ChatTextView()
    
    enum TableSection{
        case senMessage
        case incomingMessage
        
        func register(tableView:UITableView){
            switch self {
                
            case .senMessage:
                tableView.register(SendMessageTableViewCell.self, forCellReuseIdentifier: SendMessageTableViewCell.identifier)
            case .incomingMessage:
                tableView.register(ChatIncomingTableViewCell.self, forCellReuseIdentifier: ChatIncomingTableViewCell.identifier)
            }
        }
    }
    
    let sections : [TableSection] = [.senMessage,.incomingMessage]
    
    private let sendMessageButton :  UIButton = {
       let button = UIButton()
        let buttonImage = UIImage(systemName: "arrowtriangle.forward.fill")
        buttonImage?.withTintColor(.white)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "backColor")
        tableView.separatorColor =  UIColor(named: "backColor")
  
        return tableView
    }()
    
    
    
    
    private let testMessageList : [TestMessage] =  [
        .init(id: "0", userId: "0", userName: "Engin Gülek", message: "Merhaba"),
        .init(id: "1", userId: "1", userName: "Buse Işık", message: "Merhabalar"),
        .init(id: "3", userId: "0", userName: "Engin Gülek", message: "İyi Günler")
    ]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(named: "backColor")
        view.addSubview(sendMessageButton)
        view.addSubview(chatTextView)
        view.addSubview(chatTableView)
        navigationItem.title = "Name Surname"
        chatTableView.delegate = self
        chatTableView.dataSource = self
        configureContraints()
        sections.forEach { section in
            section.register(tableView: chatTableView)
        }
      
    }
    
    private func configureContraints() {
        chatTextView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(self.chatTextView, at: 0)
        self.chatTextView.layer.cornerRadius = 20
        self.chatTextView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
        self.chatTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10).isActive = true
        self.chatTextView.trailingAnchor.constraint(equalTo: sendMessageButton.leadingAnchor,constant: -10).isActive = true
        self.chatTextView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        sendMessageButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(chatTextView.snp.top)
        }
    }
}

extension ChatViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
       
        
        
       
        let message = testMessageList[indexPath.row]
        if message.userId == "0" {
            guard let cell = chatTableView.dequeueReusableCell(withIdentifier: SendMessageTableViewCell.identifier,for: indexPath) as? SendMessageTableViewCell else {return UITableViewCell()}
            
            cell.readData(getMessage: testMessageList[indexPath.row])
            
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }else {
            guard let cell = chatTableView.dequeueReusableCell(withIdentifier: ChatIncomingTableViewCell.identifier,for: indexPath) as? ChatIncomingTableViewCell else {return UITableViewCell()}
            
            cell.readData(getMessage: testMessageList[indexPath.row])
            
            cell.backgroundColor = UIColor(named: "backColor")
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderColor = UIColor(named: "backColor")?.cgColor
            return cell
        }

        
    }
}
