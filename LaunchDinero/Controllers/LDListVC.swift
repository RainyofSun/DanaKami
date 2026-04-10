//
//  LDListVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDListVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource, AutoHiddenNavigationBar {
    
    let list: [String] = [LDText(key: "All"), LDText(key: "Apply"), LDText(key: "Repayment"), LDText(key: "Finished")]
    var btns: [UIButton] = []
    
//    var data: LDOrderModel = LDOrderModel()
    
    var currentIndex: Int = 4
    
    lazy var topTip1: UILabel = UILabel(text: LDText(key: "Order list"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 20, fontStyle: InterFontWeight.Bold))
    lazy var topTip2: UILabel = UILabel(text: LDText(key: "order_tip"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Bold))
    lazy var iconImgView: UIImageView = UIImageView(image: UIImage(named: "order_coin"))
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var lineV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FFD363")
        view.layer.cornerRadius = 18
        return view
    }()
    
    lazy var gradientBgView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.setCorners([.topLeft, .topRight], radius: 25)
        view.verticalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        
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
    
    var math: [LDOrderItemModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.LDShowActivity()
        reqData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("requestOrder"), object: nil, queue: OperationQueue.main) { (sender: Notification) in
            guard let _tag = sender.object as? Int else {
                return
            }
            
            if let _v = self.headerView.viewWithTag(_tag) as? UIButton {
                self.btnClick(sender: _v)
            }
        }
        
        self.topTip2.numberOfLines = 0
        
        noDataView.clickButton.addTarget(self, action: #selector(noDataClick), for: UIControl.Event.touchUpInside)
        self.gradientView.addSubview(self.topTip1)
        self.gradientView.addSubview(self.topTip2)
        self.view.addSubview(self.gradientBgView)
        self.gradientBgView.addSubview(headerView)
        self.view.addSubview(noDataView)
        headerView.addSubview(lineV)
        self.gradientBgView.addSubview(tb)
        self.gradientView.addSubview(self.iconImgView)
        
        self.topTip1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LDStatusBarHeight + 30)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        self.topTip2.snp.makeConstraints { make in
            make.top.equalTo(self.topTip1.snp.bottom).offset(6)
            make.left.equalTo(self.topTip1)
            make.right.equalTo(self.iconImgView.snp.left).offset(-15)
        }
        
        self.iconImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(LDStatusBarHeight + 10)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(107)
        }
        
        gradientBgView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-LDHomeBarHeight - LDTabBarHeight)
            make.top.equalTo(self.topTip2.snp.bottom).offset(15)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        noDataView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(124)
            make.centerX.equalToSuperview()
        }
        
        tb.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        let btnW: CGFloat = (LDScreenWidth - 30) / CGFloat(list.count)
        let btnH: CGFloat = 44.0
        for (i, str) in list.enumerated() {
            let btn = UIButton()
            btn.setTitle(str, for: .normal)
            btn.setTitleColor(UIColor(hex: "#999999"), for: .normal)
            btn.setTitleColor(UIColor(hex: "#000000"), for: .selected)
            btn.titleLabel?.font = LDScreenWidth < 414 ? UIFont.interFont(size: 12, fontStyle: InterFontWeight.Regular) : UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)
            btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            headerView.addSubview(btn)
            self.btns.append(btn)
            
            btn.snp.makeConstraints { make in
                make.top.equalToSuperview()
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
                    make.width.equalTo(btnW)
                    make.height.equalTo(36)
                    make.center.equalTo(btn)
                }
            } else {
                btn.tag = 8 - i
            }
        }
    }
    
    @objc func btnClick(sender: UIButton) {
        btns.forEach { btn in
            btn.isSelected = false
            btn.titleLabel?.font = LDScreenWidth < 414 ? UIFont.interFont(size: 12, fontStyle: InterFontWeight.Regular) : UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)
        }
        sender.isSelected = true
        sender.titleLabel?.font = LDScreenWidth < 414 ? UIFont.interFont(size: 12, fontStyle: InterFontWeight.Bold) : UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold)
        
        lineV.snp.remakeConstraints { make in
            make.width.equalTo(sender.jf_width)
            make.height.equalTo(36)
            make.center.equalTo(sender)
        }
        currentIndex = sender.tag
        self.tb.es.startPullToRefresh()
    }
    
    
    @objc func noDataClick() {
        jumpPage(vc: self, url: "fvns://etrieved")
    }
    
    func reqData() {
        LDReqManager.request(url: .allOrderUrl(params: ["jeffrey": "\(currentIndex)"]), modelType: LDOrderModel.self) { model in
            self.view.LDHideActivity()
            self.tb.es.stopPullToRefresh()
            switch model {
            case .success(let success):
                self.math.removeAll()
                if let m = success.financial {
                    self.noDataView.isHidden = !m.mathematicians.isEmpty
                    self.math.append(contentsOf: m.mathematicians)
                } else {
                    self.noDataView.isHidden = false
                }
                
                self.tb.reloadData()
                
            case .failure(_):
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        math.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDOrderCell
        if let m = math[safe: indexPath.row] {
            cell.model = m
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = math[safe: indexPath.row] {
            allowProductDetail(vc: self, pID: "\(m.geography)")
        }
    }

}

class LDListNoDataView: UIControl {
    
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
    
    lazy var clickButton: GradientLoadingButton = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.setTitle(LDText(key: "Apply now"))
        view.setFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        view.setTitleColor(UIColor.white)
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imgV)
        self.addSubview(textLb)
        self.addSubview(self.clickButton)
        
        imgV.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        textLb.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        self.clickButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(80)
            make.top.equalTo(textLb.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
