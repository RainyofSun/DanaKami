//
//  LDOrderCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDOrderCell: LDCell {
    
    var model: LDOrderItemModel = LDOrderItemModel() {
        didSet {
            icon.kf.setImage(with: URL(string: model.writers))
            titleLb.text = model.portal
            statusV.setTitle(model.examined)
            
            agreeBtn.setAttributedTitle(NSAttributedString(string: model.help, attributes: [.foregroundColor: UIColor(hex: "#173100"), .font: UIFont.boldSystemFont(ofSize: 14), .underlineStyle: NSUnderlineStyle.single.rawValue]), for: UIControl.State.normal)
        }
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#DBDCA5")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#FFFFFF").cgColor
        return view
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "LaunchDinero",
                         font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        return lb
    }()
    
    lazy var statusV: GradientLoadingButton = {
        let view = GradientLoadingButton()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.setTitleColor(UIColor.white)
        view.setFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var divideV: UIImageView = UIImageView(image: UIImage(named: "Line"))
    
    lazy var amountItem: LDOrderCellItem = LDOrderCellItem(frame: CGRectZero)
    lazy var dateItem: LDOrderCellItem = LDOrderCellItem(frame: CGRectZero)
    
    lazy var agreeBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        return btn
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(titleLb)
        bgView.addSubview(statusV)
        bgView.addSubview(containerView)
        containerView.addSubview(divideV)
        containerView.addSubview(amountItem)
        containerView.addSubview(dateItem)
        bgView.addSubview(agreeBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(15)
            make.right.bottom.equalTo(-15)
        }
        
        icon.snp.makeConstraints { make in
            make.top.left.equalTo(15)
            make.width.height.equalTo(30)
        }
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(8)
            make.centerY.equalTo(icon)
        }
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(icon.snp.bottom).offset(15)
        }
        
        statusV.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(containerView)
            make.top.equalTo(containerView).offset(-5)
            make.height.equalTo(40)
        }
        
        divideV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(15)
        }
        
        amountItem.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.equalTo(self.divideV.snp.left)
        }
        
        dateItem.snp.makeConstraints { make in
            make.right.top.equalToSuperview()
            make.left.equalTo(divideV.snp.right)
            make.width.equalTo(amountItem)
        }
        
        agreeBtn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(statusV.snp.bottom).offset(6)
        }
    }
    
    @objc func agreeBtnClick() {
        if model.help.isEmpty {
            return
        }
        jumpPage(vc: self.parentVC(), url: model.lapses)
    }
}

class LDOrderCellItem: UIView {
    
    var model: LDOrderLevyModel = LDOrderLevyModel() {
        didSet {
            titleLb.text = model.rainmaker
            subtitleLb.text = model.emanuel
        }
    }
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "", color: UIColor.init(hex: "#999999"),
                         font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Regular))
        return lb
    }()
    
    lazy var subtitleLb: UILabel = {
        let lb = UILabel(text: "", color: .black,
                         font: UIFont.interFont(size: 24, fontStyle: InterFontWeight.Extra_Bold))
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLb)
        self.addSubview(subtitleLb)
        
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        subtitleLb.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLb)
            make.bottom.equalToSuperview().offset(-30)
            make.top.equalTo(titleLb.snp.bottom).offset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
