//
//  UserAvatarView.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/20.
//

import UIKit

class UserAvatarView: UITableViewCell {

    lazy var avatarImgView: UIImageView = UIImageView(frame: CGRectZero)
    
    lazy var userPhoneLab: UILabel = {
        let view = UILabel(frame: CGRectZero)
        view.textColor = UIColor.init(hex: "#460629")
        view.font = UIFont.boldSystemFont(ofSize: 18)
        return view
    }()

    lazy var welcomeLab: UILabel = {
        let view = UILabel(frame: CGRectZero)
        view.textColor = UIColor.init(hex: "#460629")
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    lazy var serviceImgView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "service"))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        welcomeLab.text = LDLocalLanguage.shared.languageString(key: "Welcome back")
        
        self.contentView.addSubview(self.avatarImgView)
        self.contentView.addSubview(self.userPhoneLab)
        self.contentView.addSubview(self.welcomeLab)
        self.contentView.addSubview(self.serviceImgView)
        
        self.avatarImgView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        self.userPhoneLab.snp.makeConstraints { make in
            make.left.equalTo(self.avatarImgView.snp.right).offset(8)
            make.top.equalTo(self.avatarImgView).offset(8)
        }
        
        self.welcomeLab.snp.makeConstraints { make in
            make.left.equalTo(self.userPhoneLab)
            make.top.equalTo(self.userPhoneLab.snp.bottom).offset(4)
        }
        
        self.serviceImgView.snp.makeConstraints { make in
            make.centerY.size.equalTo(self.avatarImgView)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
