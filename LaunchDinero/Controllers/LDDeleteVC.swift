//
//  LDDeleteVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/18.
//

import UIKit

class LDDeleteVC: LDBaseVC {
    
    lazy var imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "setup_delete_img"))
        return img
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "setup_img"))
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "LaunchDinero",
                         color: .white,
                         font: .boldSystemFont(ofSize: 20),
                         alignment: .center)
        return lb
    }()
    
    lazy var vLb: UILabel = {
        let lb = UILabel(text: "V\(LDDevice.info.version)",
                         color: .white,
                         alignment: .center)
        return lb
    }()
    
    lazy var contentLb: UILabel = {
        let lb = UILabel(text: LDText(key: "Delete Content"),
                         color: .white,
                         font: .systemFont(ofSize: 16),
                         alignment: .center)
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var agreeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login_no"), for: .normal)
        btn.setImage(UIImage(named: "login_yes"), for: .selected)
        btn.setTitle(LDText(key: "I have read and accept the above"), for: .normal)
        btn.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        btn.isSelected = true
        return btn
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "setup_delete_btn"), for: .normal)
        btn.setTitle(LDText(key: "Confirm"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav(backTitle: LDText(key: "Account cancellation"))
        
        self.view.addSubview(imageView)
        imageView.addSubview(icon)
        imageView.addSubview(titleLb)
        imageView.addSubview(vLb)
        imageView.addSubview(contentLb)
        self.view.addSubview(agreeBtn)
        self.view.addSubview(confirmBtn)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(LDNavMaxY + 14)
            make.centerX.equalToSuperview()
            make.width.equalTo(347)
            make.height.equalTo(278)
        }
        icon.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.left.equalTo(74)
            make.width.height.equalTo(58)
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(26)
            make.left.equalTo(icon.snp.right).offset(12)
            make.height.equalTo(28)
        }
        vLb.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(4)
            make.centerX.equalTo(titleLb)
            make.height.equalTo(22)
        }
        contentLb.snp.makeConstraints { make in
            make.left.equalTo(14)
            make.bottom.right.equalTo(-14)
            make.top.equalTo(120)
        }
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-(LDHomeBarHeight + 13))
            make.centerX.equalToSuperview()
        }
        agreeBtn.snp.makeConstraints { make in
            make.bottom.equalTo(confirmBtn.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func agreeBtnClick() {
        agreeBtn.isSelected.toggle()
    }
    
    @objc func confirmBtnClick() {
        if !agreeBtn.isSelected {
            self.popup.custom(with: LDPopupConfig()) {
                let popupV = LDPopupDeleteView(frame: CGRect(x: 0, y: 0, width: 339, height: 456))
                popupV.AgreeClourse = { [weak self] in
                    self?.agreeBtn.isSelected = true
                    self?.reqDelete()
                }
                return popupV
            }
            return
        }
        reqDelete()
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
