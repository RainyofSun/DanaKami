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
                let popupV = LDPopupDeleteView(frame: CGRect(x: 0, y: 0, width: 339, height: 456))
                popupV.AgreeClourse = { [weak self] in
                    let viewC = LDDeleteVC()
                    self?.navigationController?.pushViewController(viewC, animated: true)
                }
                return popupV
            }
        } else if indexPath.row == 2 {
            self.popup.custom(with: LDPopupConfig()) {
                let popupV = LDPopupOutView(frame: CGRectZero)
                return popupV
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
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var protoclView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.diagonalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        return view
    }()
    
    lazy var selBtn: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setImage(UIImage(named: "select_normal"), for: UIControl.State.normal)
        view.setImage(UIImage(named: "select_sel"), for: UIControl.State.selected)
        return view
    }()
    
    lazy var protocolText: UILabel = UILabel(text: LDText(key: ""), color: UIColor.black, font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Bold))
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLb.text = LDText(key: "Loan Agreement")
        self.contentLb.text = LDText(key: "Delete Agreement Content")
        confirmBtn.setTitle("\(LDText(key: "Agree and Continue")) (5s)")
        confirmBtn.isEnabled = false
        var num = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { t in
            num -= 1
            self.confirmBtn.setTitle("\(LDText(key: "Agree and Continue")) (\(num)s)")
            if num <= 0 {
                self.confirmBtn.setTitle("\(LDText(key: "Agree and Continue"))")
                self.confirmBtn.isEnabled = true
                
                self.endTimer()
            }
        })
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func confirmBtnClick() {
        super.confirmBtnClick()
        self.AgreeClourse?()
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        endTimer()
    }
}

class LDPopupOutView: LDPopupView {
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.init(hex: "#999999"), for: .normal)
        btn.titleLabel?.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
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
            make.top.equalTo(contentLb.snp.bottom).offset(15)
            make.height.equalTo(18)
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
    
    override func confirmBtnClick() {
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
    
    
    @objc func clickCancelClick() {
        
    }
}
