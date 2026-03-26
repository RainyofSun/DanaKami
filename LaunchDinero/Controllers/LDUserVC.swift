//
//  LDUserVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDUserVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource, AutoHiddenNavigationBar {
    
    var userModel: LDUserModel = LDUserModel()
    
    lazy var avatarImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "user_avatar"))
        return img
    }()
    
    lazy var nameLb: UILabel = {
        let label = UILabel(text: "**********",
                            color: UIColor.init(hex: "#460629"),
                            font: UIFont.interFont(size: 24, fontStyle: InterFontWeight.Bold))
        return label
    }()
    
    lazy var subtitleLb: UILabel = {
        let label = UILabel(text: LDText(key: "Welcome to LaunchDinero"),
                            color: UIColor.init(hex: "#460629"),
                            font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular))
        return label
    }()
    
    lazy var titleLb: UILabel = {
        let label = UILabel(text: LDText(key: "Common functions"),
                            color: UIColor(hex: "#460629"),
                            font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
        return label
    }()
    
    lazy var titleLb1: UILabel = {
        let label = UILabel(text: LDText(key: "allOrder"),
                            color: UIColor(hex: "#460629"),
                            font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
        return label
    }()
    
    lazy var arrowImg: UIImageView = UIImageView(image: UIImage(named: "Vectorsmal"))
    
    lazy var greenBgView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.setCorners([.topLeft, .topRight], radius: 20)
        view.verticalGradient([UIColor.init(hex: "#22421E"), UIColor.init(hex: "#588734")])
        
        return view
    }()

    lazy var progressBtn: ImageTopTitleBottomButton = {
        let view = ImageTopTitleBottomButton(frame: CGRectZero)
        view.set(image: UIImage(named: "progress"), title: LDText(key: "In progress"))
        view.tag = 1007
        return view
    }()
    
    lazy var repaymentBtn: ImageTopTitleBottomButton = {
        let view = ImageTopTitleBottomButton(frame: CGRectZero)
        view.set(image: UIImage(named: "repayment"), title: LDText(key: "Repayment"))
        view.tag = 1006
        return view
    }()
    
    lazy var completeBtn: ImageTopTitleBottomButton = {
        let view = ImageTopTitleBottomButton(frame: CGRectZero)
        view.set(image: UIImage(named: "complete"), title: LDText(key: "Completed"))
        view.tag = 1005
        return view
    }()
    
    lazy var bgView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.setCorners([.topLeft, .topRight], radius: 25)
        view.diagonalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        
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
        tb.register(LDUserCell.self, forCellReuseIdentifier: NSStringFromClass(LDUserCell.self))
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(avatarImg)
        self.view.addSubview(nameLb)
        self.view.addSubview(subtitleLb)
        self.view.addSubview(self.titleLb)
        self.view.addSubview(self.titleLb1)
        self.view.addSubview(self.arrowImg)
        self.view.addSubview(self.greenBgView)
        self.greenBgView.addSubview(self.progressBtn)
        self.greenBgView.addSubview(self.repaymentBtn)
        self.greenBgView.addSubview(self.completeBtn)
        self.view.addSubview(bgView)
        bgView.addSubview(tb)
        
        self.titleLb1.isUserInteractionEnabled = true
        self.titleLb1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoAllOrder)))
        self.progressBtn.addTarget(self, action: #selector(gotoOrder(sender: )), for: UIControl.Event.touchUpInside)
        self.repaymentBtn.addTarget(self, action: #selector(gotoOrder(sender: )), for: UIControl.Event.touchUpInside)
        self.completeBtn.addTarget(self, action: #selector(gotoOrder(sender: )), for: UIControl.Event.touchUpInside)
        
        avatarImg.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalToSuperview().offset(LDStatusBarHeight + 40)
            make.width.height.equalTo(100)
        }
        
        nameLb.snp.makeConstraints { make in
            make.left.equalTo(avatarImg.snp.right).offset(15)
            make.top.equalTo(avatarImg).offset(30)
        }
        
        subtitleLb.snp.makeConstraints { make in
            make.left.equalTo(nameLb)
            make.top.equalTo(nameLb.snp.bottom).offset(5)
        }
        
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(avatarImg)
            make.top.equalTo(avatarImg.snp.bottom).offset(25)
        }
        
        arrowImg.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(titleLb)
        }
        
        titleLb1.snp.makeConstraints { make in
            make.right.equalTo(arrowImg.snp.left).offset(-2)
            make.centerY.equalTo(titleLb)
        }
        
        greenBgView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.height.equalTo((LDScreenWidth - 40) * 0.31)
        }
        
        progressBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.verticalEdges.equalToSuperview().inset(15)
        }
        
        repaymentBtn.snp.makeConstraints { make in
            make.left.equalTo(progressBtn.snp.right).offset(10)
            make.verticalEdges.width.equalTo(progressBtn)
        }
        
        completeBtn.snp.makeConstraints { make in
            make.left.equalTo(repaymentBtn.snp.right).offset(10)
            make.verticalEdges.width.equalTo(repaymentBtn)
            make.right.equalToSuperview().offset(-15)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(greenBgView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-LDHomeBarHeight - LDTabBarHeight)
        }
        
        tb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reqData()
    }
    
    func reqData() {
        self.view.LDShowActivity()
        LDReqManager.request(url: .userInfoUrl, modelType: LDUserModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if let m = success.financial {
                    self.userModel = m
                    self.nameLb.text = self.userModel.userInfo.kate
                    self.tb.reloadData()
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(let failure):
                self.view.LDToast(text: failure.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.userModel.mathematicians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(LDUserCell.self), for: indexPath) as! LDUserCell
        if let m = self.userModel.mathematicians[safe: indexPath.item] {
            cell.data = m
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = self.userModel.mathematicians[safe: indexPath.item] {
            jumpPage(vc: self, url: m.infinity)
        }
    }

    @objc func gotoAllOrder() {
        jumpPage(vc: self, url: "fvb://order")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            NotificationCenter.default.post(name: NSNotification.Name("requestOrder"), object: 4)
        })
    }
    
    @objc func gotoOrder(sender: ImageTopTitleBottomButton) {
        jumpPage(vc: self, url: "fvb://order")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            NotificationCenter.default.post(name: NSNotification.Name("requestOrder"), object: sender.tag - 1000)
        })
    }
}
