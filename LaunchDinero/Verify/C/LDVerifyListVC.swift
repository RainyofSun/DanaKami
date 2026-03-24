//
//  LDVerifyListVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/20.
//

import UIKit

class LDVerifyListVC: LDVerifyBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    var verifyModel: LDVerifyModel = LDVerifyModel()
    
    var isShowAgree: Bool = false
    
    lazy var listTb: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.contentInsetAdjustmentBehavior = .never
        tb.register(LDVerifyListCell.self, forCellReuseIdentifier: "Cell")
        tb.es.addPullToRefresh {
            self.reqData()
        }
        return tb
    }()
    
    lazy var tbHeaderView: LDVerifyListHeaderView = {
        let view = LDVerifyListHeaderView(frame: CGRect(x: 0, y: 0, width: LDScreenWidth, height: 352 * LDScale + 46))
        return view
    }()
    
    lazy var agreeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login_no"), for: .normal)
        btn.setImage(UIImage(named: "login_yes"), for: .selected)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        btn.isSelected = true
        return btn
    }()
    
    lazy var agreeLb: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor(hex: "#898989"),
                         font: .systemFont(ofSize: 14),
                         alignment: .center)
        lb.numberOfLines = 0
        lb.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(agreeLbClick))
        lb.addGestureRecognizer(tap)
        lb.isHidden = true
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.LDShowActivity()
        self.reqData()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        stepV.isHidden = true
        
        self.view.addSubview(listTb)
        self.view.addSubview(agreeBtn)
        self.view.addSubview(agreeLb)
        
        listTb.tableHeaderView = tbHeaderView
        
        listTb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-LDHomeBarHeight-LDTabBarHeight)
        }
        agreeLb.snp.makeConstraints { make in
            make.bottom.equalTo(nextBtn.snp.top).offset(-14)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(LDScreenWidth - 80)
        }
        agreeBtn.snp.makeConstraints { make in
            make.right.equalTo(agreeLb.snp.left)
            make.width.height.equalTo(22)
            make.centerY.equalTo(agreeLb)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        verifyModel.promising.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDVerifyListCell
        if let m = verifyModel.promising[safe: indexPath.row] {
            cell.model = m
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currentIndex: Int = indexPath.row
        if let m = verifyModel.promising[safe: indexPath.row] {
            var type = m.bmi
            if !verifyModel.golden.bmi.isEmpty && m.society == 0 {
                type = verifyModel.golden.bmi
                for (i, model) in verifyModel.promising.enumerated() {
                    if model.bmi == type {
                        currentIndex = i
                    }
                }
            }
            pushDetail(type: type, model: m, currentIndex: currentIndex)
        }
    }
    
    func pushDetail(type: String, model: LDVerifyPromisingModel, currentIndex: Int) {
        switch type {
        case "finda":
            let viewController = LDVerifyDetailBVC()
            viewController.pID = self.pID
            viewController.OrderNo = self.OrderNo
            viewController.navTitle = model.rainmaker
            viewController.stepV.index = currentIndex
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case "findd":
            let viewController = LDVerifyDetailCVC()
            viewController.pID = self.pID
            viewController.OrderNo = self.OrderNo
            viewController.navTitle = model.rainmaker
            viewController.stepV.index = currentIndex
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        default:
            let viewController = LDVerifyDetailAVC()
            viewController.pID = self.pID
            viewController.OrderNo = self.OrderNo
            viewController.navTitle = model.rainmaker
            viewController.stepV.index = currentIndex
            viewController.type = type
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        }
    }
    
    func reqData() {
        LDReqManager.request(url: .verifyListUrl(params: ["foreign": pID]), modelType: LDVerifyModel.self) { model in
            self.view.LDHideActivity()
            self.listTb.es.stopPullToRefresh()
            switch model {
            case .success(let success):
                if let m = success.financial {
                    self.verifyModel = m
                    self.OrderNo = self.verifyModel.reel.empire
                    self.refreshData()
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        self.tbHeaderView.amountA.text = verifyModel.reel.florida
        self.tbHeaderView.amountB.text = verifyModel.reel.newcomer
        self.tbHeaderView.termA.text = verifyModel.reel.directorial.directors.rainmaker
        self.tbHeaderView.termB.text = verifyModel.reel.directorial.directors.guild
        self.tbHeaderView.rateA.text = verifyModel.reel.directorial.america.rainmaker
        self.tbHeaderView.rateB.text = verifyModel.reel.directorial.america.guild
        self.nextBtn.setTitle(verifyModel.reel.turkish, for: .normal)
        self.listTb.reloadData()
        
        self.title = verifyModel.reel.portal
        
        isShowAgree = !verifyModel.festival.rainmaker.isEmpty
        agreeBtn.isHidden = !isShowAgree
        agreeLb.isHidden = !isShowAgree
        let arr = verifyModel.festival.rainmaker.components(separatedBy: "||")
        if arr.count > 1 {
            let attr = NSMutableAttributedString(string: arr[0], attributes: [.foregroundColor: UIColor(hex: "#898989"), .font: UIFont.systemFont(ofSize: 14)])
            attr.append(NSAttributedString(string: arr[1], attributes: [.foregroundColor: UIColor(hex: "#9BCF21"), .font: UIFont.boldSystemFont(ofSize: 14), .underlineStyle: NSUnderlineStyle.single.rawValue]))
            agreeLb.attributedText = attr
        }
        
        listTb.snp.remakeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(isShowAgree ? agreeLb.snp.top : nextBtn.snp.top).offset(-14)
        }
        
        VerifyStepList.removeAll()
        for m in verifyModel.promising {
            switch m.bmi {
            case "finda":
                VerifyStepList.append(LDVerifyStepModel(img: "verify_step_1", selImg: "verify_step_1_sel"))
            case "findb":
                VerifyStepList.append(LDVerifyStepModel(img: "verify_step_2", selImg: "verify_step_2_sel"))
            case "findc":
                VerifyStepList.append(LDVerifyStepModel(img: "verify_step_3", selImg: "verify_step_3_sel"))
            case "findd":
                VerifyStepList.append(LDVerifyStepModel(img: "verify_step_4", selImg: "verify_step_4_sel"))
            case "finde":
                VerifyStepList.append(LDVerifyStepModel(img: "verify_step_5", selImg: "verify_step_5_sel"))
            default:
                break
            }
        }
    }
    
    @objc func agreeBtnClick() {
        agreeBtn.isSelected.toggle()
    }
    
    @objc func agreeLbClick() {
        jumpPage(vc: self, url: verifyModel.festival.international)
    }
    
    override func nextBtnClick() {
        
        if isShowAgree && !agreeBtn.isSelected {
            self.view.LDToast(text: LDText(key: "Please agree to the agreement"))
            return
        }
        
        let type = verifyModel.golden.bmi
        if type.isEmpty {
            LDReqManager.request(url: .playAnOrder(params: ["newcomer": verifyModel.reel.newcomer, "berlin": verifyModel.reel.empire]), modelType: LDVerifyApplyModel.self) { model in
                switch model {
                case .success(let success):
                    if success.numbers == 0, let m = success.financial {
                        LDUploadingInfoManager.point(num: 11, pID: self.pID, orderNO: self.OrderNo)
                        jumpPage(vc: self, url: m.infinity)
                        var vcs = self.navigationController?.viewControllers ?? []
                        if vcs.count >= 2 {
                            vcs.remove(at: vcs.count - 2)
                            self.navigationController?.viewControllers = vcs
                        }
                    } else {
                        self.view.LDToast(text: success.information)
                    }
                case .failure(_):
                    break
                }
            }
        } else {
            for (i, model) in verifyModel.promising.enumerated() {
                if model.bmi == type {
                    pushDetail(type: type, model: model, currentIndex: i)
                }
            }
        }
    }

}

class LDVerifyListHeaderView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: LDText(key: "verify_list_img")))
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
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Certification condition"),
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
        self.addSubview(titleLb)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(352 * LDScale)
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
