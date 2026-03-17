//
//  LDPopupView.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/17.
//

import UIKit
import JFPopup

func LDPopupConfig() -> JFPopupConfig {
    var c = JFPopupConfig.dialog
    c.toastPosition = .center
    c.isDismissible = false
    return c
}

class LDPopupView: UIView {
    
    var nextClourse: (() -> Void)?
    
    lazy var imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "popup_agreement"))
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "popup_close"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .systemFont(ofSize: 18),
                         alignment: .center)
        return lb
    }()
    
    lazy var contentLb: UILabel = {
        let lb = UILabel(text: "",
                         font: .systemFont(ofSize: 15),
                         alignment: .center)
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "popup_btn"), for: .normal)
        btn.setTitle(LDText(key: "Next"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.addSubview(backBtn)
        imageView.addSubview(titleLb)
        imageView.addSubview(contentLb)
        imageView.addSubview(confirmBtn)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(23)
            make.right.equalToSuperview()
            make.width.height.equalTo(52)
        }
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(96)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(25)
        }
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.centerX.equalToSuperview()
        }
        contentLb.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(14)
            make.left.equalTo(27)
            make.right.equalTo(-27)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-29)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backBtnClick() {
        self.parentVC().dismiss(animated: true)
    }
    
    @objc func confirmBtnClick() {
        self.nextClourse?()
        self.parentVC().dismiss(animated: true)
    }
    
}
