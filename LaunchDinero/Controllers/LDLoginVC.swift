//
//  LDLoginVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/15.
//

import UIKit

class LDLoginVC: LDBaseVC {
    
    var loginTimer: Timer?
    
    lazy var imgView: GradientView = {
        var view = GradientView(frame: CGRectZero)
        view.verticalGradient([UIColor.init(hex: "#22421E"), UIColor(hex: "#588734")])
        return view
    }()
    
    lazy var nanGuaimgView: UIImageView = UIImageView(image: UIImage(named: "nangua"))
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back_white"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var logoimgView: UIImageView = UIImageView(image: UIImage(named: "logo"))
    
    lazy var nameLab: UILabel = {
        let view = UILabel(frame: CGRectZero)
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 24)
        let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        view.text = displayName
        return view
    }()
    
    lazy var welcomeLab: UILabel = {
        let view = UILabel(frame: CGRectZero)
        view.textColor = .white.withAlphaComponent(0.6)
        view.font = UIFont.systemFont(ofSize: 14)
        view.text = LDLocalLanguage.shared.languageString(key: "Borrow with greater peace of mind.")
        return view
    }()
    
    lazy var gradientView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.verticalGradient([UIColor.init(hex: "#FFFFFF"), UIColor.init(hex: "#D8D99E")])
        view.setCorners([.topLeft, .topRight], radius: 25)
        return view
    }()
    
    lazy var tipLab1: UILabel = {
        let view = UILabel(frame: CGRectZero)
        view.textColor = UIColor.init(hex: "#460629")
        view.font = UIFont.boldSystemFont(ofSize: 24)
        view.text = LDLocalLanguage.shared.languageString(key: "Sign in")
        return view
    }()
    
    lazy var tipLab2: UILabel = {
        let view = UILabel(frame: CGRectZero)
        view.textColor = .black.withAlphaComponent(0.8)
        view.font = UIFont.systemFont(ofSize: 14)
        view.text = LDLocalLanguage.shared.languageString(key: "Log in using your mobile phone number")
        return view
    }()
    
    lazy var phoneView: LDLoginItemView = {
        let view = LDLoginItemView(frame: .zero)
        view.textField.placeholder = LDText(key: "Enter your phone number")
        view.isCode = false
        return view
    }()
    
    lazy var codeView: LDLoginItemView = {
        let view = LDLoginItemView(frame: .zero)
        view.isCode = true
        view.textField.placeholder = LDText(key: "Verification code")
        return view
    }()
    
    lazy var voiceBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(LDText(key: "Voice verification"), for: .normal)
        btn.setTitleColor(UIColor(hex: "#000000"), for: .normal)
        btn.setImage(UIImage(named: LDText(key: "login_voice")), for: .normal)
        btn.addTarget(self, action: #selector(voiceBtnClick), for: .touchUpInside)
        btn.titleLabel?.attributedText = NSAttributedString(string: LDText(key: "login_voice"), attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.boldSystemFont(ofSize: 14)])
        return btn
    }()
    
    lazy var loginBtn: GradientLoadingButton = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.setTitle(LDText(key: "Log in"))
        view.setFont(UIFont.interFont(size: 20, fontStyle: InterFontWeight.Bold))
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.layer.cornerRadius = 27
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(loginBtnClick(sender: )), for: .touchUpInside)
        return view
    }()
    
    lazy var privateView: UIControl = {
        let view = UIControl(frame: CGRectZero)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.isSelected = true
        view.addTarget(self, action: #selector(agreeBtnClick(sender: )), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    lazy var agreeImgView: UIImageView = UIImageView(image: UIImage(named: "login_yes"))
    
    lazy var privacyLb: UILabel = {
        let label = UILabel(text: LDText(key: "Privacy Agreement"))
        label.numberOfLines = 0
        let paras: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paras.paragraphSpacing = 4
        var mutabStr: NSMutableAttributedString = NSMutableAttributedString(string: LDText(key: "login_privice"), attributes: [.foregroundColor: UIColor.black, .font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold), .paragraphStyle: paras])
        let arsiw: NSAttributedString = NSAttributedString(string: LDText(key: "Privacy Agreement"), attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor(hex: "#460629")])
        mutabStr.append(arsiw)
        label.attributedText = mutabStr
        label.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(privacyLbClick))
        label.addGestureRecognizer(tapGes)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgView)
        imgView.addSubview(nanGuaimgView)
        imgView.addSubview(backBtn)
        imgView.addSubview(logoimgView)
        imgView.addSubview(nameLab)
        imgView.addSubview(welcomeLab)
        
        self.view.addSubview(self.gradientView)
        gradientView.addSubview(self.tipLab1)
        gradientView.addSubview(self.tipLab2)
        gradientView.addSubview(phoneView)
        gradientView.addSubview(codeView)
        gradientView.addSubview(voiceBtn)
        gradientView.addSubview(loginBtn)
        gradientView.addSubview(privateView)
        privateView.addSubview(agreeImgView)
        privateView.addSubview(privacyLb)
        
        imgView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(LDScreenWidth * 0.64)
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(LDStatusBarHeight)
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
        }
        
        nanGuaimgView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom)
            make.right.equalToSuperview().offset(-20)
        }
        
        logoimgView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(30)
            make.left.equalTo(backBtn)
            make.size.equalTo(65)
        }
        
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(logoimgView).offset(8)
            make.left.equalTo(logoimgView.snp.right).offset(8)
        }
        
        welcomeLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom).offset(6)
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(logoimgView.snp.bottom).offset(20)
        }
        
        tipLab1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(logoimgView)
        }
        
        tipLab2.snp.makeConstraints { make in
            make.top.equalTo(tipLab1.snp.bottom).offset(6)
            make.left.equalTo(tipLab1)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(tipLab2.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        codeView.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(phoneView)
        }
        
        voiceBtn.snp.makeConstraints { make in
            make.top.equalTo(codeView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(voiceBtn.snp.bottom).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(54)
        }
        
        privateView.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(25)
            make.horizontalEdges.equalTo(loginBtn)
        }
        
        privacyLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.verticalEdges.equalToSuperview().inset(10)
            make.right.equalTo(agreeImgView.snp.left).offset(-8)
        }
        
        agreeImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(35)
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
            self.codeView.getLb.textColor = UIColor.init(hex: "#999999")
            self.codeView.getLb.backgroundColor = UIColor.init(hex: "#EEEEEE")
            self.codeView.getView.isUserInteractionEnabled = false
            
            if second <= 0 {
                self.codeView.getView.isUserInteractionEnabled = true
                self.codeView.getLb.text = LDText(key: "Get code")
                self.codeView.getLb.textColor = UIColor.init(hex: "#460629")
                self.codeView.getLb.backgroundColor = UIColor.init(hex: "#FFD363")
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
    
    @objc func loginBtnClick(sender: GradientLoadingButton) {
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
    
    @objc func agreeBtnClick(sender: UIControl) {
        sender.isSelected.toggle()
        if sender.isSelected {
            agreeImgView.image = UIImage(named: "login_yes")
        } else {
            agreeImgView.image = UIImage(named: "login_no")
        }
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
        if privateView.isSelected {
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
                    make.right.equalToSuperview().offset(-15)
                    make.centerY.equalTo(textField)
                    make.height.equalTo(34)
                }
                
                getLb.snp.makeConstraints { make in
                    make.left.equalTo(10)
                    make.right.equalTo(-10)
                    make.centerY.equalToSuperview()
                    make.width.equalTo(100)
                }
                
                textField.snp.makeConstraints { make in
                    make.verticalEdges.equalToSuperview()
                    make.left.equalToSuperview().offset(15)
                    make.width.equalTo(LDScreenWidth * 0.7)
                    make.height.equalTo(50)
                }
                
                self.textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
            } else {
                self.addSubview(self.leftView)
                self.leftView.addSubview(self.phoneView)
                self.leftView.addSubview(self.codeLab)
                
                leftView.snp.makeConstraints { make in
                    make.left.verticalEdges.equalToSuperview()
                }
                
                self.phoneView.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(15)
                    make.centerY.equalToSuperview()
                    make.size.equalTo(CGSize(width: 15, height: 20))
                }
                
                self.codeLab.snp.makeConstraints { make in
                    make.left.equalTo(self.phoneView.snp.right).offset(8)
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview().offset(-8)
                    make.width.equalTo(35)
                }
                
                textField.snp.makeConstraints { make in
                    make.left.equalTo(leftView.snp.right)
                    make.verticalEdges.equalToSuperview()
                    make.height.equalTo(50)
                    make.right.equalToSuperview().offset(-15)
                }
            }
        }
    }
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 50))
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 50))
        tf.keyboardType = .numberPad
        tf.textColor = UIColor(hex: "#333333")
        tf.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold)
        return tf
    }()
    
    lazy var getView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FFD363")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 17
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var getLb: UILabel = {
        let label = UILabel(text: LDText(key: "Get code"),
                            color: .black,
                            font: .systemFont(ofSize: 14))
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var leftView: UIView = UIView(frame: CGRectZero)
    lazy var phoneView: UIImageView = UIImageView(image: UIImage(named: "Union"))
    lazy var codeLab: UILabel = UILabel(text: LDText(key: "+62"), color: UIColor.init(hex: "#460629"), font: UIFont.systemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hex: "#D8D99E")
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        
        self.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
