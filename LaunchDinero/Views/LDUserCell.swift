//
//  LDUserCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/16.
//

import UIKit

class LDUserCell: UITableViewCell {
    
    var data: LDUserMathematiciansModel = LDUserMathematiciansModel() {
        didSet {
            self.icon.kf.setImage(with: URL(string: data.centuries))
            self.titleLb.text = data.rainmaker
        }
    }
    
    lazy var costView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
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
        let img = UIImageView(image: UIImage(named: "Vector"))
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.costView)
        self.costView.addSubview(icon)
        self.costView.addSubview(titleLb)
        self.costView.addSubview(arrowImg)
        
        self.costView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        
        icon.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.left.equalTo(14)
            make.width.height.equalTo(45)
        }
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(8)
            make.right.equalTo(-16)
            make.centerY.equalTo(icon)
        }
        
        arrowImg.snp.makeConstraints { make in
            make.centerY.equalTo(icon)
            make.right.equalTo(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
