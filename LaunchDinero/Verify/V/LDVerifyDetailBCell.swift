//
//  LDVerifyDetailBCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailBCell: LDCell {
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "", color: UIColor.init(hex: "#460629"),
                         font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
        return lb
    }()
    
    lazy var bgImg: UIView = {
        let img = UIView(frame: CGRectZero)
        img.backgroundColor = UIColor(hex: "#C9D9A0")
        img.layer.cornerRadius = 18
        img.clipsToBounds = true
        return img
    }()
    
    lazy var iconImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    
    lazy var photoImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "camera"))
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: CGRectZero)
        return view
    }()

    lazy var tipLab: UILabel = {
        let lb = UILabel(text: LDText(key: "Upload"), color: UIColor.init(hex: "#460629"),
                         font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        return lb
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(bgImg)
        self.bgImg.addSubview(iconImg)
        self.bgImg.addSubview(self.containerView)
        self.containerView.addSubview(self.photoImg)
        self.containerView.addSubview(self.tipLab)
        
        titleLb.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        bgImg.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalTo(-20)
        }
        
        iconImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(iconImg.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        photoImg.snp.makeConstraints { make in
            make.left.verticalEdges.equalToSuperview()
        }
        
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(photoImg.snp.right).offset(8)
            make.centerY.equalTo(photoImg)
            make.right.equalToSuperview()
        }
    }

}
