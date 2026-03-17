//
//  LDLDVerifyDetailConfirmPopup.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDLDVerifyDetailConfirmPopup: LDPopupView {
    
    var CommitClourse:(() -> Void)?
    
    lazy var nameV: LDLDVerifyDetailConfirmPopupItem = {
        let view = LDLDVerifyDetailConfirmPopupItem(frame: .zero)
        view.titleLb.text = LDText(key: "Name")
        view.textImg.isHidden = true
        return view
    }()
    
    lazy var IDV: LDLDVerifyDetailConfirmPopupItem = {
        let view = LDLDVerifyDetailConfirmPopupItem(frame: .zero)
        view.titleLb.text = LDText(key: "ID No.")
        view.textImg.isHidden = true
        view.textTf.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var dateV: LDLDVerifyDetailConfirmPopupItem = {
        let view = LDLDVerifyDetailConfirmPopupItem(frame: .zero)
        view.titleLb.text = LDText(key: "Date Birth")
        view.textImg.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dateClick))
        view.textV.addGestureRecognizer(tap)
        return view
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLb.text = LDText(key: "Please confirm")
        contentLb.text = LDText(key: "Verify confirm desc")
        contentLb.textColor = UIColor(hex: "#F14343")
        contentLb.font = .systemFont(ofSize: 12)
        imageView.image = UIImage(named: "popup_confirm")
        
        contentLb.snp.remakeConstraints { make in
            make.bottom.equalTo(confirmBtn.snp.top).offset(-18)
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        
        self.addSubview(bgView)
        self.insertSubview(bgView, belowSubview: titleLb)
        
        self.addSubview(nameV)
        self.addSubview(IDV)
        self.addSubview(dateV)
        
        nameV.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(13)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        IDV.snp.makeConstraints { make in
            make.top.equalTo(nameV.snp.bottom).offset(12)
            make.left.right.equalTo(nameV)
        }
        dateV.snp.makeConstraints { make in
            make.top.equalTo(IDV.snp.bottom).offset(12)
            make.left.right.equalTo(nameV)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(titleLb).offset(-13)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(dateV).offset(20)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dateClick() {
        self.parentVC().popup.custom(with: LDPopupConfig()) {
            let popup = LDLDVerifyDetailDatePopup(frame: CGRect(x: 0, y: 0, width: 339, height: 502))
            popup.titleLb.text = LDText(key: "Date Birth")
            popup.selectedClourse = { date in
                self.dateV.textTf.text = date
            }
            return popup
        }
    }
    
    override func confirmBtnClick() {
        self.LDShowActivity()
        LDReqManager.request(url: .verifySFZConfirmUrl(params: ["scorer": nameV.textTf.text ?? "",
                                                                "listed": "11",
                                                                "resulter": IDV.textTf.text ?? "",
                                                                "nominee": dateV.textTf.text ?? ""]), modelType: LDModel.self) { model in
            self.LDHideActivity()
            switch model {
            case .success(let success):
                if success.numbers == 0 {
                    self.CommitClourse?()
                    self.parentVC().dismiss(animated: true)
                } else {
                    self.LDToast(text: success.information)
                }
            case .failure(_):
                break
            }
        }
    }
    
}

class LDLDVerifyDetailConfirmPopupItem: LDVerifyDetailCItemView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLb.textColor = UIColor(hex: "#2E2E2E")
        titleLb.snp.remakeConstraints { make in
            make.left.equalTo(14)
            make.top.right.equalToSuperview()
            make.height.equalTo(24)
        }
        textV.snp.remakeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(42)
        }
        textTf.snp.remakeConstraints { make in
            make.left.equalTo(14)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-14)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
