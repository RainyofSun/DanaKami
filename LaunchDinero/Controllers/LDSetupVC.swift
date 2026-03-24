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
                let popupV = LDPopupOutView(frame: CGRect(x: 0, y: 0, width: 339, height: 268))
                return popupV
            }
        }
    }

}

class LDPopupDeleteView: LDPopupView {
    
    var AgreeClourse:(() -> Void)?
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLb.text = LDText(key: "Loan Agreement")
        self.contentLb.text = LDText(key: "Delete Agreement Content")
        confirmBtn.setTitle("\(LDText(key: "Agree and Continue")) (5s)", for: .normal)
        confirmBtn.isEnabled = false
        var num = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { t in
            num -= 1
            self.confirmBtn.setTitle("\(LDText(key: "Agree and Continue")) (\(num)s)", for: .normal)
            if num <= 0 {
                self.confirmBtn.setTitle("\(LDText(key: "Agree and Continue"))", for: .normal)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.image = UIImage(named: "popup_out")
        self.titleLb.text = LDText(key: "Sign out")
        self.contentLb.text = LDText(key: "Are you sure you want to exit the application?")
        confirmBtn.setTitle(LDText(key: "Confirm"), for: .normal)
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
}
