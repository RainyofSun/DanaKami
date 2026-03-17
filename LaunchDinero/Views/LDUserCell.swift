//
//  LDUserCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/16.
//

import UIKit

class LDUserCell: UICollectionViewCell {
    
    var data: LDUserMathematiciansModel = LDUserMathematiciansModel() {
        didSet {
            self.icon.kf.setImage(with: URL(string: data.centuries))
            self.titleLb.text = data.rainmaker
        }
    }
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#2A2727"),
                         font: .systemFont(ofSize: 14))
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    lazy var arrowImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "user_arrow"))
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(hex: "#173100").cgColor
        
        self.addSubview(icon)
        self.addSubview(titleLb)
        self.addSubview(arrowImg)
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(14)
            make.width.height.equalTo(45)
        }
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(8)
            make.right.equalTo(-16)
            make.centerY.equalTo(icon)
        }
        arrowImg.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.right.equalTo(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
