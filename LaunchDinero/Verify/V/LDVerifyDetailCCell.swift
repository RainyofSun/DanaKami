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
                if "\(r.listeder)" == model.irish {
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
    
    lazy var bgView1: UIView = {
        let view = UIView(frame: CGRectZero)
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.init(hex: "#EEEEEE").cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    lazy var bgView2: UIView = {
        let view = UIView(frame: CGRectZero)
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.init(hex: "#EEEEEE").cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "", color: UIColor.init(hex: "#460629"),
                         font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
        return lb
    }()
    
    lazy var relationV: LDVerifyDetailCItemView = {
        let view = LDVerifyDetailCItemView(frame: .zero)
        view.textImg.image = UIImage(named: "Vector")
        let tap = UITapGestureRecognizer(target: self, action: #selector(relationClick))
        view.textV.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var phoneV: LDVerifyDetailCItemView = {
        let view = LDVerifyDetailCItemView(frame: .zero)
        let tap = UITapGestureRecognizer(target: self, action: #selector(phoneClick))
        view.textV.addGestureRecognizer(tap)
        return view
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.relationV.textV.backgroundColor = .clear
        self.relationV.textV.layer.borderColor = UIColor.clear.cgColor
        self.phoneV.textV.backgroundColor = .clear
        self.phoneV.textV.layer.borderColor = UIColor.clear.cgColor
        
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(self.bgView1)
        self.bgView1.addSubview(relationV)
        self.contentView.addSubview(self.bgView2)
        self.bgView2.addSubview(phoneV)
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalToSuperview()
            make.right.equalTo(-16)
            make.height.equalTo(25)
        }
        
        self.bgView1.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(17)
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        
        relationV.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        self.bgView2.snp.makeConstraints { make in
            make.top.equalTo(bgView1.snp.bottom).offset(10)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(-14)
        }
        
        phoneV.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
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
        lb.textColor = UIColor.init(hex: "#460629")
        lb.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)
        return lb
    }()
    
    lazy var textV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#EEEEEE")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
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
        }
        textTf.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(textImg.snp.left).offset(-14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
