//
//  LDVerifyDetailCCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDVerifyDetailCCell: LDCell {
    
    var relationClourse: (() -> Void)?
    var contactsClourse: (() -> Void)?
    
    var model: LDVerifyDetailCItemModel = LDVerifyDetailCItemModel() {
        didSet {
            titleLb.text = model.rainmaker
            relationV.titleLb.text = model.important
            relationV.textTf.placeholder = model.tensions
            relationV.textTf.text = ""
            for r in model.lyrics {
                if r.listed == model.irish {
                    relationV.textTf.text = r.scorer
                }
            }
            phoneV.titleLb.text = model.protestant
            phoneV.textTf.placeholder = model.catholic
            phoneV.textTf.text = model.scorer + " - " + model.backdrop
            if model.scorer.isEmpty || model.backdrop.isEmpty {
                phoneV.textTf.text = ""
            }
        }
    }
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .boldSystemFont(ofSize: 18))
        return lb
    }()
    
    lazy var relationV: LDVerifyDetailCItemView = {
        let view = LDVerifyDetailCItemView(frame: .zero)
        view.textImg.image = UIImage(named: "verify_list_arrow")
        let tap = UITapGestureRecognizer(target: self, action: #selector(relationClick))
        view.textV.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var phoneV: LDVerifyDetailCItemView = {
        let view = LDVerifyDetailCItemView(frame: .zero)
        view.textImg.image = UIImage(named: "verify_emergent_contacts")
        let tap = UITapGestureRecognizer(target: self, action: #selector(phoneClick))
        view.textV.addGestureRecognizer(tap)
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(relationV)
        self.contentView.addSubview(phoneV)
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview()
            make.right.equalTo(-16)
            make.height.equalTo(25)
        }
        relationV.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(17)
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        phoneV.snp.makeConstraints { make in
            make.top.equalTo(relationV.snp.bottom)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(-14)
        }
    }
    
    @objc func relationClick() {
        relationClourse?()
    }
    
    @objc func phoneClick() {
        contactsClourse?()
    }

}

class LDVerifyDetailCItemView: UIView {
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "")
        return lb
    }()
    
    lazy var textV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F5F5F5")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var textTf: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 16)
        tf.backgroundColor = .clear
        tf.isUserInteractionEnabled = false
        tf.textColor = UIColor(hex: "#333333")
        return tf
    }()
    
    lazy var textImg: UIImageView = {
        let img = UIImageView()
        img.isUserInteractionEnabled = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLb)
        self.addSubview(textV)
        textV.addSubview(textTf)
        textV.addSubview(textImg)
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(2)
            make.top.right.equalToSuperview()
            make.height.equalTo(22)
        }
        textV.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(46)
        }
        textImg.snp.makeConstraints { make in
            make.right.equalTo(-14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        textTf.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(textImg.snp.left).offset(-14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
