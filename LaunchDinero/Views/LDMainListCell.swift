//
//  LDMainListCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/19.
//

import UIKit

class LDMainListCell: LDCell {
    
    var model: LDMainrRamanujanModel = LDMainrRamanujanModel() {
        didSet {
            icon.kf.setImage(with: URL(string: model.writers))
            titleLb.text = model.portal
            
            amountB.text = model.southeastern
            amountA.text = model.telly
            
            applyBtn.setTitle(model.turkish)
        }
    }
    
    lazy var bgImageView: UIView = {
        let img = UIView(frame: CGRectZero)
        img.backgroundColor = .white
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView(frame: CGRectZero)
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .boldSystemFont(ofSize: 14))
        return lb
    }()
    
    lazy var amountA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#000000"),
                         font: UIFont.interFont(size: 28, fontStyle: InterFontWeight.Bold))
        return lb
    }()
    lazy var amountB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#999999"),
                         font: .systemFont(ofSize: 12))
        return lb
    }()
    
    lazy var applyBtn: GradientLoadingButton = {
        let btn = GradientLoadingButton(frame: CGRectZero)
        btn.setFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        btn.setTitleColor(.white)
        btn.layer.cornerRadius = 17
        btn.clipsToBounds = true
        return btn
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(bgImageView)
        bgImageView.addSubview(icon)
        bgImageView.addSubview(titleLb)
        bgImageView.addSubview(amountA)
        bgImageView.addSubview(amountB)
        bgImageView.addSubview(applyBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        icon.snp.makeConstraints { make in
            make.top.left.equalTo(15)
            make.width.height.equalTo(26)
        }
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(9)
            make.centerY.equalTo(icon)
            make.right.equalTo(applyBtn.snp.left).offset(-9)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.height.equalTo(34)
            make.centerY.equalToSuperview()
        }
        
        amountA.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.left.equalTo(icon)
        }
        
        amountB.snp.makeConstraints { make in
            make.top.equalTo(amountA.snp.bottom).offset(3)
            make.left.equalTo(amountA)
            make.bottom.equalToSuperview().offset(-15)
        }
    }

}
