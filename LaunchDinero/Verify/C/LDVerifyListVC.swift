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
        tb.register(LDVerifyListHeaderView.self, forCellReuseIdentifier: NSStringFromClass(LDVerifyListHeaderView.self))
        tb.es.addPullToRefresh {
            self.reqData()
        }
        return tb
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
        
        listTb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20 + LDNavMaxY)
            make.horizontalEdges.equalToSuperview()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let _header = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(LDVerifyListHeaderView.self), for: indexPath) as? LDVerifyListHeaderView else {
                return UITableViewCell()
            }
            
            _header.amountA.text = verifyModel.reel.florida
            _header.amountB.text = verifyModel.reel.newcomer
            if let _url = URL(string: verifyModel.reel.writers) {
                _header.ppLogoImgView.kf.setImage(with: _url, options: [.transition(.fade(0.3))])
            }
            _header.ppNameLab.text = verifyModel.reel.portal
            
            return _header
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LDVerifyListCell
        cell.buildListView(cellList: verifyModel.promising)
        cell.cellDelegate = self
        return cell
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
            make.top.equalToSuperview().offset(20 + LDNavMaxY)
            make.horizontalEdges.equalToSuperview()
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

extension LDVerifyListVC: VerifyCellProtocol {
    func didTapCellControl(index: Int) {
        var currentIndex: Int = index
        if let m = verifyModel.promising[safe: index] {
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
}

class LDVerifyListHeaderView: UITableViewCell {
    
    lazy var bgImageView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.diagonalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var ppLogoImgView: UIImageView = {
        let view = UIImageView(frame: CGRectZero)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    lazy var ppNameLab: UILabel = UILabel(text: "", color: UIColor.black, font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
    
    lazy var dotView1: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.init(hex: "#FF8844")
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dotView2: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.init(hex: "#C9BDAA")
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dotView3: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.init(hex: "#C9BDAA")
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var amountA: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        return lb
    }()
    
    lazy var amountB: UILabel = {
        let lb = UILabel(text: "",
                         color: UIColor.init(hex: "#460629"),
                         font: UIFont.interFont(size: 50, fontStyle: InterFontWeight.Extra_Bold))
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(bgImageView)
        bgImageView.addSubview(ppLogoImgView)
        bgImageView.addSubview(ppNameLab)
        bgImageView.addSubview(dotView1)
        bgImageView.addSubview(dotView2)
        bgImageView.addSubview(dotView3)
        bgImageView.addSubview(amountA)
        bgImageView.addSubview(amountB)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        self.ppLogoImgView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
            make.size.equalTo(30)
        }
        
        self.ppNameLab.snp.makeConstraints { make in
            make.left.equalTo(self.ppLogoImgView.snp.right).offset(10)
            make.centerY.equalTo(self.ppLogoImgView)
        }
        
        self.dotView2.snp.makeConstraints { make in
            make.centerY.equalTo(self.ppLogoImgView)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(8)
        }
        
        self.dotView1.snp.makeConstraints { make in
            make.bottom.equalTo(self.dotView2.snp.top).offset(-4)
            make.size.centerX.equalTo(self.dotView2)
        }
        
        self.dotView3.snp.makeConstraints { make in
            make.top.equalTo(self.dotView2.snp.bottom).offset(4)
            make.size.centerX.equalTo(self.dotView2)
        }
        
        amountA.snp.makeConstraints { make in
            make.top.equalTo(ppLogoImgView.snp.bottom).offset(15)
            make.left.equalTo(15)
        }
        
        amountB.snp.makeConstraints { make in
            make.top.equalTo(amountA.snp.bottom).offset(10 * LDScale)
            make.left.equalTo(amountA)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
