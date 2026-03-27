//
//  LDVerifyDetailASelectCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailASelectCell: LDCell, UITableViewDelegate, UITableViewDataSource {
    
    var selectedClourse: ((_ selectedType: String) -> Void)?
    
    var model: LDVerifyDetailAItemModel = LDVerifyDetailAItemModel() {
        didSet {
            titleLb.text = model.rainmaker
            titleImg.image = UIImage(named: model.isShow ? "verify_select_-" : "verify_select_+")
            self.tb.reloadData()
            self.tb.snp.remakeConstraints { make in
                make.top.equalTo(titleView.snp.bottom).offset(-28)
                make.left.right.equalTo(titleView)
                make.height.equalTo(model.isShow ? 28 + 40 * model.lyrics.count : 28)
                make.bottom.equalTo(-14)
            }
        }
    }
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#173100").cgColor
        return view
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#173100"))
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var titleImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "verify_select_+"))
        return img
    }()
    
    lazy var tb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.separatorStyle = .none
        tb.backgroundColor = .white
        tb.layer.masksToBounds = true
        tb.layer.cornerRadius = 14
        tb.layer.borderWidth = 1
        tb.layer.borderColor = UIColor(hex: "#9BCF21").cgColor
        tb.bounces = false
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.register(LDVerifyDetailASelectItemCell.self, forCellReuseIdentifier: "Cell")
        tb.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 28))
        return tb
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(tb)
        self.contentView.addSubview(titleView)
        titleView.addSubview(titleImg)
        titleView.addSubview(titleLb)
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        titleImg.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        titleLb.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(-50)
        }
        tb.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(-28)
            make.left.right.equalTo(titleView)
            make.height.equalTo(28)
            make.bottom.equalTo(-14)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.lyrics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDVerifyDetailASelectItemCell
        if let m = self.model.lyrics[safe: indexPath.row] {
            cell.model = m
            cell.titleLb.backgroundColor = "\(m.listeder)" == model.choice ? UIColor(hex: "#173100") : .white
            cell.titleLb.textColor = "\(m.listeder)" == model.choice ? .white : UIColor(hex: "#173100")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = self.model.lyrics[safe: indexPath.row] {
            model.choice = "\(m.listeder)"
            self.tb.reloadData()
            self.selectedClourse?("\(m.listeder)")
        }
    }

}

class LDVerifyDetailASelectItemCell: LDCell {
    
    var model: LDVerifyDetailCLyricsModel = LDVerifyDetailCLyricsModel() {
        didSet {
            titleLb.text = model.scorer
        }
    }
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#173100"),
                         alignment: .center)
        lb.layer.masksToBounds = true
        lb.layer.cornerRadius = 8
        lb.backgroundColor = .white
        return lb
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(titleLb)
        
        titleLb.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(40)
        }
    }
}
