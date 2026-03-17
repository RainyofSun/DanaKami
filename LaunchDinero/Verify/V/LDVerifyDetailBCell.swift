//
//  LDVerifyDetailBCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailBCell: LDCell {
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .boldSystemFont(ofSize: 16),
                         alignment: .center)
        return lb
    }()
    
    lazy var bgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    
    lazy var iconImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "verify_photo_camera"))
        return img
    }()
    
    lazy var photoImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        img.layer.masksToBounds = true
        return img
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(bgImg)
        self.contentView.addSubview(iconImg)
        self.contentView.addSubview(photoImg)
        
        titleLb.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        bgImg.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(-20)
        }
        iconImg.snp.makeConstraints { make in
            make.center.equalTo(bgImg)
        }
        photoImg.snp.makeConstraints { make in
            make.edges.equalTo(bgImg)
        }
    }

}
