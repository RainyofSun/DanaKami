//
//  LDListVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDListVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    let list: [String] = [LDText(key: "All"), LDText(key: "Apply"), LDText(key: "Repayment"), LDText(key: "Finished")]
    var btns: [UIButton] = []
    
    var data: LDOrderModel = LDOrderModel()
    
    var currentIndex: Int = 4
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Order list"),
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 18))
        return lb
    }()
    
    lazy var lineV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#9BCF21")
        return view
    }()
    
    lazy var tb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.register(LDOrderCell.self, forCellReuseIdentifier: "Cell")
        tb.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        tb.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        tb.es.addPullToRefresh {
            self.reqData()
        }
        return tb
    }()
    
    lazy var noDataView: LDListNoDataView = {
        let view = LDListNoDataView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.LDShowActivity()
        reqData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(headerView)
        self.view.addSubview(noDataView)
        headerView.addSubview(titleLb)
        headerView.addSubview(lineV)
        self.view.addSubview(tb)
        
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        noDataView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(124)
            make.centerX.equalToSuperview()
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(LDStatusBarHeight)
            make.left.equalTo(14)
            make.height.equalTo(44)
        }
        tb.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-(LDHomeBarHeight + LDTabBarHeight))
        }
        
        let btnW: CGFloat = LDScreenWidth / CGFloat(list.count)
        let btnH: CGFloat = 44.0
        for (i, str) in list.enumerated() {
            let btn = UIButton()
            btn.setTitle(str, for: .normal)
            btn.setTitleColor(UIColor(hex: "#333333"), for: .normal)
            btn.setTitleColor(UIColor(hex: "#555555"), for: .selected)
            btn.titleLabel?.font = .systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            headerView.addSubview(btn)
            self.btns.append(btn)
            
            btn.snp.makeConstraints { make in
                make.top.equalTo(titleLb.snp.bottom)
                make.left.equalTo(CGFloat(i) * btnW)
                make.width.equalTo(btnW)
                make.height.equalTo(btnH)
                make.bottom.equalToSuperview()
            }
            
            if i == 0 {
                btn.tag = 4
                btn.isSelected = true
                btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
                lineV.snp.makeConstraints { make in
                    make.bottom.equalTo(-8)
                    make.width.equalTo(17)
                    make.height.equalTo(2)
                    make.centerX.equalTo(btn)
                }
            } else {
                btn.tag = 8 - i
            }
        }
    }
    
    @objc func btnClick(sender: UIButton) {
        btns.forEach { btn in
            btn.isSelected = false
            btn.titleLabel?.font = .systemFont(ofSize: 14)
        }
        sender.isSelected = true
        sender.titleLabel?.font = .boldSystemFont(ofSize: 15)
        lineV.snp.remakeConstraints { make in
            make.bottom.equalTo(-8)
            make.width.equalTo(17)
            make.height.equalTo(2)
            make.centerX.equalTo(sender)
        }
        currentIndex = sender.tag
        self.tb.es.startPullToRefresh()
    }
    
    func reqData() {
        LDReqManager.request(url: .allOrderUrl(params: ["jeffrey": "\(currentIndex)"]), modelType: LDOrderModel.self) { model in
            self.view.LDHideActivity()
            self.tb.es.stopPullToRefresh()
            switch model {
            case .success(let success):
                self.data = LDOrderModel()
                if let m = success.financial {
                    self.data = m
                    self.tb.reloadData()
                }
            case .failure(_):
                break
            }
            self.noDataView.isHidden = self.data.mathematicians.count > 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.mathematicians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDOrderCell
        if let m = self.data.mathematicians[safe: indexPath.row] {
            cell.model = m
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = self.data.mathematicians[safe: indexPath.row] {
            allowProductDetail(vc: self, pID: "\(m.geography)")
        }
    }

}

class LDListNoDataView: UIView {
    
    lazy var imgV: UIImageView = {
        let img = UIImageView(image: UIImage(named: "order_list_empty"))
        return img
    }()
    
    lazy var textLb: UILabel = {
        let lb = UILabel(text: LDText(key: "There are currently no orders available"),
                         color: UIColor(hex: "#999999"),
                         font: .systemFont(ofSize: 14),
                         alignment: .center)
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imgV)
        self.addSubview(textLb)
        
        imgV.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        textLb.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom).offset(20)
            make.left.equalTo(78)
            make.right.equalTo(-78)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
