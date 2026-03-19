//
//  LDWecomeVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/24.
//

import UIKit

protocol RetryRequestProtocol: AnyObject {
    func retryRequest()
}

class LDWecomeVC: LDBaseVC {
    
    weak open var retryDelegate: RetryRequestProtocol?
    
    lazy var imgV: UIImageView = {
        let img = UIImageView(image: UIImage(named: "wecome"))
        return img
    }()
    
    lazy var applogoImgView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "appLogo"))
        return img
    }()

    lazy var retryBtn: GradientLoadingButton = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.setTitle(LDLocalLanguage.shared.languageString(key: "retry"))
        view.setImage(UIImage(named: "loading"))
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgV)
        imgV.addSubview(applogoImgView)
        self.view.addSubview(retryBtn)
        
        retryBtn.addTarget(self, action: #selector(clickReetryButton(sender: )), for: UIControl.Event.touchUpInside)
        
        imgV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        applogoImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        retryBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(36)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SceneDelegate().startApp(isWecome: true)
    }

    @objc func clickReetryButton(sender: GradientLoadingButton) {
        self.retryDelegate?.retryRequest()
    }
}
