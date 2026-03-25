//
//  LDSetupVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/17.
//

import UIKit

class LDSetupVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.bounces = false
        tb.register(SetupTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(SetupTableViewCell.self))
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = LDText(key: "Set up")
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let _cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(SetupTableViewCell.self), for: indexPath) as? SetupTableViewCell else {
            return UITableViewCell()
        }
        
        _cell.showVersion = indexPath.row == 0
        
        if indexPath.row == 0 {
            _cell.titleLab.text = LDText(key: "Version")
        } else if indexPath.row == 1 {
            _cell.titleLab.text = LDText(key: "Account cancellation")
        } else {
            _cell.titleLab.text = LDText(key: "Logout")
        }
        
        return _cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.popup.custom(with: LDPopupConfig()) {
                let popupV = LDPopupDeleteView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 288, height: 415)))
                popupV.AgreeClourse = { [weak self] in
                    self?.reqDelete()
                }
                return popupV
            }
        } else if indexPath.row == 2 {
            self.popup.custom(with: LDPopupConfig()) {
                let popupV = LDPopupOutView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 288, height: 317)))
                return popupV
            }
        }
    }

    func reqDelete() {
        self.view.LDShowActivity()
        LDReqManager.request(url: .userDeleteUrl, modelType: LDModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    UserDefaults.standard.set(nil, forKey: LDUserDefaultKey_SID)
                    if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene, let w = ws.windows.first {
                        w.rootViewController = LDTabBarC()
                    }
                }
            case .failure(_):
                break
            }
        }
    }
}

class LDPopupDeleteView: LDPopupView {
    
    var AgreeClourse:(() -> Void)?
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.init(hex: "#999999"), for: .normal)
        btn.titleLabel?.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)
        btn.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
        return btn
    }()
    
    lazy var protoclView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.diagonalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        view.setCorners([.bottomLeft,.bottomRight], radius: 25)
        return view
    }()
    
    lazy var selBtn: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setImage(UIImage(named: "select_normal"), for: UIControl.State.normal)
        view.setImage(UIImage(named: "select_sel"), for: UIControl.State.selected)
        return view
    }()
    
    lazy var protocolText: UILabel = UILabel(text: LDText(key: "I have read and accept the above"), color: UIColor.black, font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Bold))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        protocolText.numberOfLines = 0
        self.imageView.image = UIImage(named: "pop_cancel")?.stretchable()
        self.titleLb.text = LDText(key: "Delete Account")
        self.contentLb.text = LDText(key: "Delete Agreement Content")
        confirmBtn.setTitle(LDText(key: "Think again"))
        cancelBtn.setTitle(LDText(key: "Account cancellation"), for: UIControl.State.normal)
        selBtn.addTarget(self, action: #selector(clickSelButton(sender: )), for: UIControl.Event.touchUpInside)
    }
    
    override func addPopSubViews() {
        super.addPopSubViews()
        
        imageView.addSubview(cancelBtn)
        imageView.addSubview(protoclView)
        protoclView.addSubview(selBtn)
        protoclView.addSubview(protocolText)
    }
    
    override func layoutPopViews() {
        super.layoutPopViews()
        
        confirmBtn.snp.remakeConstraints { make in
            make.top.equalTo(contentLb.snp.bottom).offset(25)
            make.height.equalTo(36)
            make.horizontalEdges.equalTo(contentLb)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.height.horizontalEdges.equalTo(confirmBtn)
            make.top.equalTo(confirmBtn.snp.bottom)
        }
        
        protoclView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(7)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(cancelBtn.snp.bottom)
        }
        
        selBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        
        protocolText.snp.makeConstraints { make in
            make.left.equalTo(selBtn.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickSelButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func clickCancelButton() {
        if !selBtn.isSelected {
            LDToast(text: LDText(key: "cancel Toast"))
            return
        }
        self.AgreeClourse?()
        self.backBtnClick()
    }
}

class LDPopupOutView: LDPopupView {
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.init(hex: "#999999"), for: .normal)
        btn.titleLabel?.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.image = UIImage(named: "pop_logout")?.stretchable()
        self.titleLb.text = LDText(key: "Sign out")
        self.contentLb.text = LDText(key: "Are you sure you want to exit the application?")
        confirmBtn.setTitle(LDText(key: "Think again"))
        cancelBtn.setTitle(LDText(key: "Confirm log out"), for: UIControl.State.normal)
        cancelBtn.addTarget(self, action: #selector(clickCancelClick), for: UIControl.Event.touchUpInside)
    }
    
    override func addPopSubViews() {
        super.addPopSubViews()
        imageView.addSubview(cancelBtn)
    }
    
    override func layoutPopViews() {
        super.layoutPopViews()
        
        confirmBtn.snp.remakeConstraints { make in
            make.top.equalTo(contentLb.snp.bottom).offset(25)
            make.height.equalTo(36)
            make.horizontalEdges.equalTo(contentLb)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.height.horizontalEdges.equalTo(confirmBtn)
            make.bottom.equalTo(-15)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickCancelClick() {
        self.LDShowActivity()
        LDReqManager.request(url: .userOutUrl, modelType: LDModel.self) { model in
            self.LDHideActivity()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    UserDefaults.standard.set(nil, forKey: LDUserDefaultKey_SID)
                    if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene, let w = ws.windows.first {
                        w.rootViewController = LDTabBarC()
                    }
                }
            case .failure(_):
                break
            }
        }
    }
}
