//
//  SendMessageTableViewCell.swift
//  SalonApp
//
//  Created by engin gülek on 28.07.2023.
//

import UIKit
import SnapKit
class SendMessageTableViewCell: UITableViewCell {
    static let identifier = "SendMessageTableViewCell"
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(messageLabel)
        self.contentView.layer.cornerRadius = 10
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.safeAreaLayoutGuide.snp.centerY)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
    }
    
    func readData(getMessage:TestMessage) {
        messageLabel.text = getMessage.message
    }

}
