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
            
            amountA.text = model.southeastern
            amountB.text = model.telly
            
            termA.text = model.leading
            termB.text = model.female
            
            rateA.text = model.satellite
            rateB.text = model.actors
            
            applyBtn.setTitle(model.turkish, for: .normal)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_2_list_img"))
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_2_list_icon"))
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .boldSystemFont(ofSize: 14))
        return lb
    }()
    
    lazy var amountA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#555555"),
                         font: .systemFont(ofSize: LDLocalLanguage.shared.localLanguage == .es ? 12 : 14),
                         alignment: .center)
        return lb
    }()
    lazy var amountB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#9BCF21"),
                         font: .systemFont(ofSize: 16),
                         alignment: .center)
        return lb
    }()
    
    lazy var termA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .systemFont(ofSize: LDLocalLanguage.shared.localLanguage == .es ? 12 : 14),
                         alignment: .center)
        return lb
    }()
    lazy var termB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 15),
                         alignment: .center)
        return lb
    }()
    
    lazy var rateA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .systemFont(ofSize: LDLocalLanguage.shared.localLanguage == .es ? 12 : 14),
                         alignment: .center)
        return lb
    }()
    lazy var rateB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 15),
                         alignment: .center)
        return lb
    }()
    
    lazy var applyBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "main_2_list_btn"), for: .normal)
        btn.setTitle("", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var lineImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_2_line"))
        return img
    }()

    override func setupSubviews() {
        super.setupSubviews()
        self.contentView.addSubview(bgImageView)
        bgImageView.addSubview(icon)
        bgImageView.addSubview(titleLb)
        bgImageView.addSubview(amountA)
        bgImageView.addSubview(amountB)
        bgImageView.addSubview(termA)
        bgImageView.addSubview(termB)
        bgImageView.addSubview(rateA)
        bgImageView.addSubview(rateB)
        bgImageView.addSubview(applyBtn)
        bgImageView.addSubview(lineImg)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.right.bottom.equalTo(-14)
            make.height.equalTo(117)
        }
        icon.snp.makeConstraints { make in
            make.top.left.equalTo(12)
            make.width.height.equalTo(26)
        }
        applyBtn.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.centerY.equalTo(icon)
            make.width.equalTo(108)
            make.height.equalTo(34)
        }
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(9)
            make.centerY.equalTo(icon)
            make.right.equalTo(applyBtn.snp.left).offset(-9)
        }
        lineImg.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalTo(12)
            make.right.equalTo(-12)
        }
        let w: CGFloat = (LDScreenWidth - 52) / 3
        let h: CGFloat = 20
        termA.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(w)
            make.height.equalTo(h)
        }
        termB.snp.makeConstraints { make in
            make.top.equalTo(termA.snp.bottom).offset(6)
            make.left.right.height.equalTo(termA)
        }
        amountA.snp.makeConstraints { make in
            make.top.width.height.equalTo(termA)
            make.right.equalTo(termA.snp.left)
        }
        amountB.snp.makeConstraints { make in
            make.top.equalTo(termB)
            make.left.right.height.equalTo(amountA)
        }
        rateA.snp.makeConstraints { make in
            make.top.width.height.equalTo(termA)
            make.left.equalTo(termA.snp.right)
        }
        rateB.snp.makeConstraints { make in
            make.top.equalTo(termB)
            make.left.right.height.equalTo(rateA)
        }
    }

}
