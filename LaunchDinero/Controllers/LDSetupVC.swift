//
//  LDSetupVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/17.
//

import UIKit

class LDSetupVC: LDBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    lazy var icon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "setup_img"))
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "LaunchDinero",
                         font: .boldSystemFont(ofSize: 20),
                         alignment: .center)
        return lb
    }()
    
    lazy var vLb: UILabel = {
        let lb = UILabel(text: "V\(LDDevice.info.version)",
                         color: UIColor(hex: "#9BCF21"),
                         alignment: .center)
        return lb
    }()
    
    lazy var lineV: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "#EBEBEB")
        return v
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .clear
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.showsHorizontalScrollIndicator = false
        tb.bounces = false
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav(backTitle: LDText(key: "Set up"))
        
        self.view.addSubview(icon)
        self.view.addSubview(titleLb)
        self.view.addSubview(vLb)
        self.view.addSubview(tableView)
        self.view.addSubview(lineV)
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(LDNavMaxY + 51)
            make.centerX.equalToSuperview()
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        vLb.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        lineV.snp.makeConstraints { make in
            make.top.equalTo(vLb.snp.bottom).offset(32)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(1)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        47
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let icon = UIImageView(image: UIImage(named: indexPath.row == 0 ? "setup_delete" : "setup_out"))
        cell.contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        let lb = UILabel(text: LDText(key: indexPath.row == 0 ? "Account cancellation" : "Logout"),
                         font: .systemFont(ofSize: 15))
        cell.contentView.addSubview(lb)
        lb.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(14)
            make.centerY.equalToSuperview()
        }
        
        let divideV = UIView()
        divideV.backgroundColor = UIColor(hex: "#EBEBEB")
        cell.contentView.addSubview(divideV)
        divideV.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.popup.custom(with: LDPopupConfig()) {
                let popupV = LDPopupDeleteView(frame: CGRect(x: 0, y: 0, width: 339, height: 456))
                popupV.AgreeClourse = { [weak self] in
                    let viewC = LDDeleteVC()
                    self?.navigationController?.pushViewController(viewC, animated: true)
                }
                return popupV
            }
        } else {
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
