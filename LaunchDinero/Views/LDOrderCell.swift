//
//  LDOrderCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDOrderCell: LDCell, UITableViewDelegate, UITableViewDataSource {
    
    var model: LDOrderItemModel = LDOrderItemModel() {
        didSet {
            icon.kf.setImage(with: URL(string: model.writers))
            titleLb.text = model.portal
            statusLb.text = model.examined
            agreeLb.attributedText = NSAttributedString(string: model.help, attributes: [.foregroundColor: UIColor(hex: "#173100"), .font: UIFont.boldSystemFont(ofSize: 14), .underlineStyle: NSUnderlineStyle.single.rawValue])
            checkBtn.isHidden = model.help.isEmpty
//            checkBtn.setTitle(model.turkish, for: .normal)
            self.tb.reloadData()
            
            self.tb.snp.remakeConstraints { make in
                make.top.equalTo(divideV.snp.bottom).offset(5)
                make.left.right.equalToSuperview()
                make.height.equalTo(CGFloat(model.levy.count) * 30)
                if model.help.isEmpty {
                    make.bottom.equalTo(-18)
                }
            }
        }
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#173100").cgColor
        return view
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "LaunchDinero",
                         font: .boldSystemFont(ofSize: 14))
        return lb
    }()
    
    lazy var statusV: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(hex: "#EB7005")
        return view
    }()
    lazy var statusLb: UILabel = {
        let lb = UILabel(text: "Apply",
                         color: .white,
                         font: .boldSystemFont(ofSize: 14),
                         alignment: .center)
        return lb
    }()
    
    lazy var divideV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F0F0F0")
        return view
    }()
    
    lazy var agreeLb: UILabel = {
        let lb = UILabel()
        lb.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(agreeBtnClick))
        lb.addGestureRecognizer(tap)
        return lb
    }()
    
    lazy var agreeBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var checkBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: "#173100")
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.setTitle(LDText(key: "Check"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var tb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.isUserInteractionEnabled = false
        tb.register(LDOrderCellItem.self, forCellReuseIdentifier: "Cell")
        return tb
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(titleLb)
        bgView.addSubview(statusV)
        statusV.addSubview(statusLb)
        bgView.addSubview(divideV)
        bgView.addSubview(tb)
        bgView.addSubview(agreeLb)
        bgView.addSubview(checkBtn)
        bgView.addSubview(agreeBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.right.bottom.equalTo(-14)
        }
        icon.snp.makeConstraints { make in
            make.top.left.equalTo(14)
            make.width.height.equalTo(30)
        }
        statusV.snp.makeConstraints { make in
            make.right.equalTo(-14)
            make.centerY.equalTo(icon)
            make.height.equalTo(27)
        }
        statusLb.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.bottom.equalToSuperview()
        }
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(6)
            make.centerY.equalTo(icon)
            make.right.equalTo(statusV.snp.left).offset(-10)
        }
        divideV.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(1)
        }
        tb.snp.makeConstraints { make in
            make.top.equalTo(divideV.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        checkBtn.snp.makeConstraints { make in
            make.top.equalTo(tb.snp.bottom).offset(5)
            make.right.equalTo(-14)
            make.width.equalTo(108)
            make.height.equalTo(34)
            make.bottom.equalTo(-18)
        }
        agreeLb.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.centerY.equalTo(checkBtn)
        }
        agreeBtn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(tb.snp.bottom)
        }
    }
    
    @objc func agreeBtnClick() {
        if model.help.isEmpty {
            return
        }
        jumpPage(vc: self.parentVC(), url: model.lapses)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.levy.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDOrderCellItem
        if let m = model.levy[safe: indexPath.row] {
            cell.model = m
        }
        return cell
    }

}

class LDOrderCellItem: LDCell {
    
    var model: LDOrderLevyModel = LDOrderLevyModel() {
        didSet {
            titleLb.text = model.rainmaker
            subtitleLb.text = model.emanuel
        }
    }
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .systemFont(ofSize: 14))
        return lb
    }()
    
    lazy var subtitleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .boldSystemFont(ofSize: 14),
                         alignment: .right)
        return lb
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(subtitleLb)
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.centerY.equalToSuperview()
        }
        subtitleLb.snp.makeConstraints { make in
            make.right.equalTo(-14)
            make.centerY.equalToSuperview()
        }
    }
}
