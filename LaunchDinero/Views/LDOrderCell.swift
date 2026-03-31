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
            
            if !model.help.isEmpty {
                agreeBtn.setAttributedTitle(NSAttributedString(string: model.help, attributes: [.foregroundColor: UIColor(hex: "#173100"), .font: UIFont.boldSystemFont(ofSize: 14), .underlineStyle: NSUnderlineStyle.single.rawValue]), for: UIControl.State.normal)
            }
            buildCellItem(levy: model.levy)
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
        bgView.addSubview(containerView)
        bgView.addSubview(statusV)
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
        
        agreeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(icon)
            make.right.equalToSuperview().offset(-15)
        }
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(icon.snp.bottom).offset(15)
        }
        
        statusV.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(containerView)
            make.top.equalTo(containerView.snp.bottom).offset(-5)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    @objc func agreeBtnClick() {
        if model.help.isEmpty {
            return
        }
        jumpPage(vc: self.parentVC(), url: model.lapses)
    }
    
    func buildCellItem(levy: [LDOrderLevyModel]) {
        
        self.containerView.subviews.forEach { item in
            if let _tt = item as? LDOrderCellItem {
                _tt.removeFromSuperview()
            }
        }
        
        var topCellItem: LDOrderCellItem?
        levy.enumerated().forEach { (index, modelItem) in
            let _item = LDOrderCellItem(frame: CGRectZero)
            _item.titleLb.text = modelItem.rainmaker
            _item.subtitleLb.text = modelItem.emanuel
            _item.showDash = index != (levy.count - 1)
            
            self.containerView.addSubview(_item)
            
            if let _top = topCellItem {
                if index == levy.count - 1 {
                    _item.snp.makeConstraints { make in
                        make.top.equalTo(_top.snp.bottom)
                        make.horizontalEdges.equalTo(_top)
                        make.bottom.equalToSuperview().offset(-5)
                    }
                } else {
                    _item.snp.makeConstraints { make in
                        make.top.equalTo(_top.snp.bottom)
                        make.horizontalEdges.equalTo(_top)
                    }
                }
            } else {
                _item.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(5)
                    make.horizontalEdges.equalToSuperview().inset(15)
                }
            }
            
            topCellItem = _item
        }
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
                         font: UIFont.interFont(size: 24, fontStyle: InterFontWeight.Extra_Bold), alignment: .right)
        return lb
    }()
    
    var showDash: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLb)
        self.addSubview(subtitleLb)
        
        titleLb.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        subtitleLb.snp.makeConstraints { make in
            make.right.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if showDash {
            let dash = CAShapeLayer()
            dash.strokeColor = UIColor.lightGray.cgColor
            dash.lineWidth = 1
            dash.lineDashPattern = [4, 2]
            
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: 0, y: bounds.height - 1),
                CGPoint(x: bounds.width, y: bounds.height - 1)
            ])
            
            dash.path = path
            dash.frame = bounds
            layer.addSublayer(dash)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
