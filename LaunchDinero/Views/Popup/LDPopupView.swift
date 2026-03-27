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
                         font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold),
                         alignment: .center)
        return lb
    }()
    
    lazy var contentLb: UILabel = {
        let lb = UILabel(text: "",
                         font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Regular),
                         alignment: .center)
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var confirmBtn: GradientLoadingButton = {
        let btn = GradientLoadingButton(frame: CGRectZero)
        btn.setTitle(LDText(key: "Next"))
        btn.setTitleColor(.white)
        btn.setFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        btn.layer.cornerRadius = 18
        btn.clipsToBounds = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addPopSubViews()
        layoutPopViews()
    }
    
    func addPopSubViews() {
        self.addSubview(imageView)
        self.addSubview(backBtn)
        imageView.addSubview(titleLb)
        imageView.addSubview(contentLb)
        imageView.addSubview(confirmBtn)
    }
    
    func layoutPopViews() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.right.equalTo(imageView)
            make.width.height.equalTo(52)
        }
        
        titleLb.snp.makeConstraints { make in
            make.top.equalTo(125)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(25)
        }
        
        contentLb.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.top.equalTo(contentLb.snp.bottom).offset(15)
            make.bottom.equalTo(-15)
            make.height.equalTo(36)
            make.horizontalEdges.equalTo(contentLb)
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
