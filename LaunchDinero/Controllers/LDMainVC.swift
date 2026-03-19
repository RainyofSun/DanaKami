//
//  LDMainVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDMainVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var isList: Bool = false
    
    var mainData: LDMainModel = LDMainModel()
    var itemModel: LDMainrRamanujanModel = LDMainrRamanujanModel()
    var listModel: LDMainrRamanujanModel = LDMainrRamanujanModel()
    var list: [LDMainrRamanujanModel] = []
    var bannerList: [LDMainrRamanujanModel] = []
    
    lazy var mainTb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.contentInsetAdjustmentBehavior = .never
        tb.register(LDMainCell.self, forCellReuseIdentifier: "Cell1")
        tb.register(LDMainListCell.self, forCellReuseIdentifier: "Cell2")
        tb.es.addPullToRefresh {
            self.reqData()
        }
        return tb
    }()
    
    lazy var headerV: LDMainHeaderView = {
        let view = LDMainHeaderView(frame: CGRect(x: 0, y: 0, width: LDScreenWidth, height: 416 * LDScale + 46))
        view.applyBtn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = isList ? .white : UIColor(hex: "#9BCF21")
        
        self.view.addSubview(mainTb)
        
        mainTb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-LDHomeBarHeight-LDTabBarHeight)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            LDPermissionManager.tracking()
        }
        
        self.view.LDShowActivity()
        self.reqData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isList ? list.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! LDMainListCell
            if let m = list[safe: indexPath.row] {
                cell.model = m
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! LDMainCell
        cell.model = self.itemModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isList {
            if let m = list[safe: indexPath.row] {
                allowProductDetail(vc: self, pID: "\(m.flag)")
            }
        }
    }
    
    func reqData() {
        
        LDUploadingInfoManager.location()
        LDUploadingInfoManager.idfaIdfv()
        LDUploadingInfoManager.deviceInfo()
        
        LDReqManager.request(url: .mainUrl, modelType: LDMainModel.self) { model in
            self.view.LDHideActivity()
            self.mainTb.es.stopPullToRefresh()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    if let m = success.financial {
                        self.mainData = m
                        self.refreshData()
                    }
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        isList = false
        for item in mainData.mathematicians {
            if item.listeder == "homeb" {
                if let m = item.ramanujan[safe: 0] {
                    self.itemModel = m
                }
            } else if item.listeder == "homec" {
                isList = true
                if let m = item.ramanujan[safe: 0] {
                    self.listModel = m
                }
            } else if item.listeder == "homed" {
                isList = true
                self.list = item.ramanujan
            }
        }
        self.view.backgroundColor = isList ? .white : UIColor(hex: "#9BCF21")
        
        headerV.amountA.text = listModel.southeastern
        headerV.amountB.text = listModel.telly
        headerV.termA.text = listModel.leading
        headerV.termB.text = listModel.female
        headerV.rateA.text = listModel.satellite
        headerV.rateB.text = listModel.actors
        headerV.applyBtn.setTitle(listModel.turkish, for: .normal)
        
        mainTb.tableHeaderView = isList ? headerV : UIView()
        self.mainTb.reloadData()
    }
    
    @objc func applyBtnClick() {
        if isLogin(currentVC: self) {
            allowProductDetail(vc: self, pID: "\(self.listModel.flag)")
        }
    }

}

class LDMainHeaderView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: LDText(key: "main_2_img")))
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var amountA: UILabel = {
        let lb = UILabel(text: "",
                         color: .white)
        return lb
    }()
    lazy var amountB: UILabel = {
        let lb = UILabel(text: "",
                         color: .white,
                         font: UIFont(name: "Racing Sans One", size: 58) ?? .systemFont(ofSize: 58))
        return lb
    }()
    
    lazy var termI: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_1_term"))
        return img
    }()
    lazy var termA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .systemFont(ofSize: 14))
        return lb
    }()
    lazy var termB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 15))
        return lb
    }()
    
    lazy var rateI: UIImageView = {
        let img = UIImageView(image: UIImage(named: "main_1_rate"))
        return img
    }()
    lazy var rateA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .systemFont(ofSize: 14))
        return lb
    }()
    lazy var rateB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#333333"),
                         font: .boldSystemFont(ofSize: 15))
        return lb
    }()
    
    lazy var applyBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "main_1_btn"), for: .normal)
        btn.setTitle("", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 22)
        btn.addTarget(self, action: #selector(applyBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Loan supermarket"),
                         font: .boldSystemFont(ofSize: 16))
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgImageView)
        bgImageView.addSubview(amountA)
        bgImageView.addSubview(amountB)
        bgImageView.addSubview(termI)
        bgImageView.addSubview(termA)
        bgImageView.addSubview(termB)
        bgImageView.addSubview(rateI)
        bgImageView.addSubview(rateA)
        bgImageView.addSubview(rateB)
        bgImageView.addSubview(applyBtn)
        self.addSubview(titleLb)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(416 * LDScale)
        }
        amountA.snp.makeConstraints { make in
            make.top.equalTo(123 * LDScale)
            make.left.equalTo(14)
            make.height.equalTo(22)
        }
        amountB.snp.makeConstraints { make in
            make.top.equalTo(amountA.snp.bottom).offset(5 * LDScale)
            make.left.equalTo(14)
            make.height.equalTo(73)
        }
        termI.snp.makeConstraints { make in
            make.top.equalTo(286 * LDScale)
            make.left.equalTo(isiPhoneX ? 28 : 42)
            make.width.height.equalTo(35)
        }
        termA.snp.makeConstraints { make in
            make.left.equalTo(termI.snp.right).offset(10)
            make.top.equalTo(termI)
        }
        termB.snp.makeConstraints { make in
            make.left.equalTo(termA)
            make.bottom.equalTo(termI)
        }
        rateA.snp.makeConstraints { make in
            make.top.equalTo(termI)
            make.right.equalTo(isiPhoneX ? -28 : -42)
        }
        rateI.snp.makeConstraints { make in
            make.top.width.height.equalTo(termI)
            make.right.equalTo(rateA.snp.left).offset(-10)
        }
        rateB.snp.makeConstraints { make in
            make.bottom.equalTo(rateI)
            make.left.equalTo(rateA)
        }
        applyBtn.snp.makeConstraints { make in
            make.left.equalTo(28)
            make.right.equalTo(-28)
            make.bottom.equalTo(-28 + LDScale)
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(14)
            make.left.equalTo(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func applyBtnClick() {
        
    }
}
