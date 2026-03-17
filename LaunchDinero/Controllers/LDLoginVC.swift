//
//  LDLoginVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/15.
//

import UIKit

class LDLoginVC: LDBaseVC {
    
    var loginTimer: Timer?
    
    lazy var imgView: UIImageView = {
        let img = UIImageView(image: UIImage(named: LDText(key: "login_img")))
        return img
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back_white"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var phoneView: LDLoginItemView = {
        let view = LDLoginItemView(frame: .zero)
        view.titleLb.text = LDText(key: "Phone number")
        view.textField.placeholder = LDText(key: "Enter your phone number")
        return view
    }()
    
    lazy var codeView: LDLoginItemView = {
        let view = LDLoginItemView(frame: .zero)
        view.isCode = true
        view.titleLb.text = LDText(key: "Verification code")
        view.textField.placeholder = LDText(key: "Verification code")
        return view
    }()
    
    lazy var voiceBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(LDText(key: "Voice verification"), for: .normal)
        btn.setTitleColor(UIColor(hex: "#9BCF21"), for: .normal)
        btn.setImage(UIImage(named: LDText(key: "login_voice")), for: .normal)
        btn.addTarget(self, action: #selector(voiceBtnClick), for: .touchUpInside)
        btn.titleLabel?.attributedText = NSAttributedString(string: LDText(key: "login_voice"), attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.boldSystemFont(ofSize: 14)])
        return btn
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "login_btn"), for: .normal)
        btn.setTitle(LDText(key: "Log in"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var agreeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(LDText(key: "I have read and agree"), for: .normal)
        btn.setTitleColor(UIColor(hex: "#898989"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setImage(UIImage(named: "login_no"), for: .normal)
        btn.setImage(UIImage(named: "login_yes"), for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnClick), for: .touchUpInside)
        btn.isSelected = true
        return btn
    }()
    
    lazy var privacyLb: UILabel = {
        let label = UILabel(text: LDText(key: "Privacy Agreement"))
        label.attributedText = NSAttributedString(string: LDText(key: "Privacy Agreement"), attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor(hex: "#9BCF21")])
        label.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(privacyLbClick))
        label.addGestureRecognizer(tapGes)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgView)
        self.view.addSubview(backBtn)
        self.view.addSubview(phoneView)
        self.view.addSubview(codeView)
        self.view.addSubview(voiceBtn)
        self.view.addSubview(loginBtn)
        self.view.addSubview(agreeBtn)
        self.view.addSubview(privacyLb)
        
        imgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(LDStatusBarHeight)
            make.width.height.equalTo(50)
            make.left.equalToSuperview()
        }
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(12)
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        codeView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(12)
            make.left.right.equalTo(phoneView)
        }
        voiceBtn.snp.makeConstraints { make in
            make.top.equalTo(codeView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        loginBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-(14 + LDHomeBarHeight))
            make.centerX.equalToSuperview()
        }
        privacyLb.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginBtn.snp.top).offset(-12)
            make.height.equalTo(20)
        }
        agreeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(privacyLb.snp.top).offset(-3)
            make.height.equalTo(20)
        }
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(getCodeClick))
        codeView.getView.addGestureRecognizer(tapGes)
    }
    
    @objc func backBtnClick() {
        self.dismiss(animated: true)
    }
    
    @objc func getCodeClick() {
        if !checkPhone() {
            return
        }
        if !checkAgree() {
            return
        }
        self.view.LDShowActivity()
        LDReqManager.request(url: .loginCodeUrl(params: ["kate": self.phoneView.textField.text ?? ""]), modelType: LDModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                self.view.LDToast(text: success.information)
                if success.numbers == 0 {
                    self.startTimer()
                    self.codeView.textField.becomeFirstResponder()
                }
            case .failure(let failure):
                self.view.LDToast(text: failure.localizedDescription)
            }
        }
        
    }
    
    func startTimer() {
        var second: Int = 60
        loginTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { t in
            second -= 1
            self.codeView.getLb.text = "\(second)s"
            self.codeView.getView.isUserInteractionEnabled = false
            
            if second <= 0 {
                self.codeView.getView.isUserInteractionEnabled = true
                self.codeView.getLb.text = LDText(key: "Get code")
                
                self.cancelTimer()
            }
        })
    }
    
    func cancelTimer() {
        loginTimer?.invalidate()
        loginTimer = nil
    }
    
    @objc func voiceBtnClick() {
        if !checkPhone() {
            return
        }
        if !checkAgree() {
            return
        }
        self.view.LDShowActivity()
        LDReqManager.request(url: .loginVoiceUrl(params: ["kate": self.phoneView.textField.text ?? ""]), modelType: LDModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                self.view.LDToast(text: success.information)
                if success.numbers == 0 {
                    self.codeView.textField.becomeFirstResponder()
                }
            case .failure(let failure):
                self.view.LDToast(text: failure.localizedDescription)
            }
        }
    }
    
    @objc func loginBtnClick() {
        if !checkPhone() {
            return
        }
        if !checkCode() {
            return
        }
        if !checkAgree() {
            return
        }
        self.view.LDShowActivity()
        LDReqManager.request(url: .loginUrl(params: ["tied": self.phoneView.textField.text ?? "",
                                                     "notes": self.codeView.textField.text ?? ""]), modelType: LDLoginModel.self) { model in
            self.view.LDHideActivity()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    LDUploadingInfoManager.point(num: 1)
                    if let data = success.financial {
                        UserDefaults.standard.set(data.consensus, forKey: LDUserDefaultKey_SID)
                        if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene, let w = ws.windows.first {
                            w.rootViewController = LDTabBarC()
                        }
                    }
                } else {
                    self.view.LDToast(text: success.information)
                }
            case .failure(let failure):
                self.view.LDToast(text: failure.localizedDescription)
            }
        }
    }
    
    @objc func agreeBtnClick() {
        agreeBtn.isSelected.toggle()
    }
    
    @objc func privacyLbClick() {
        let viewController = LDHTMLVC()
        viewController.webUrl = "https://rupantar-investments.com/LCPrivacyPolicy.html"
        viewController.modalPresentationStyle = .fullScreen
        viewController.hidesBottomBarWhenPushed = true
        self.present(UINavigationController(rootViewController: viewController), animated: true)
    }
    
    deinit {
        cancelTimer()
    }
    
    func checkPhone() -> Bool {
        if let phone = self.phoneView.textField.text, phone.count > 0 {
            return true
        } else {
            self.view.LDToast(text: LDText(key: "Enter your phone number"))
            return false
        }
    }
    
    func checkCode() -> Bool {
        if let code = self.codeView.textField.text, code.count > 0 {
            return true
        } else {
            self.view.LDToast(text: LDText(key: "Verification code"))
            return false
        }
    }
    
    func checkAgree() -> Bool {
        if agreeBtn.isSelected {
            return true
        } else {
            self.view.LDToast(text: LDText(key: "Please agree to the agreement"))
            return false
        }
    }

}

class LDLoginItemView: UIView {
    
    var isCode: Bool = false {
        didSet {
            if isCode {
                self.addSubview(getView)
                getView.addSubview(getLb)
                
                getView.snp.makeConstraints { make in
                    make.right.equalTo(textField).offset(-6)
                    make.centerY.equalTo(textField)
                    make.height.equalTo(38)
                }
                getLb.snp.makeConstraints { make in
                    make.left.equalTo(10)
                    make.right.equalTo(-10)
                    make.centerY.equalToSuperview()
                }
                
                self.textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
            }
        }
    }
    
    lazy var titleLb: UILabel = {
        let label = UILabel(text: "")
        return label
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 12
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 50))
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 50))
        tf.keyboardType = .numberPad
        tf.textColor = UIColor(hex: "#333333")
        tf.font = .systemFont(ofSize: 14)
        return tf
    }()
    
    lazy var getView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#173100")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 19
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var getLb: UILabel = {
        let label = UILabel(text: LDText(key: "Get code"),
                            color: .white,
                            font: .systemFont(ofSize: 14))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLb)
        self.addSubview(textField)
        
        titleLb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(22)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
