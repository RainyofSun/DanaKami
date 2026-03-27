//
//  LDLDVerifyDetailConfirmPopup.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDLDVerifyDetailConfirmPopup: LDPopupView {
    
    var CommitClourse:(() -> Void)?
    var pid: String = ""

    var nameV: LDLDVerifyDetailConfirmPopupItem?
    var IDV: LDLDVerifyDetailConfirmPopupItem?
    var dateV: LDLDVerifyDetailConfirmPopupItem?
    var timestr: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentLb.isHidden = true
        imageView.image = nil
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        backBtn.setImage(UIImage(named: "vertify_pop_close"), for: UIControl.State.normal)
        confirmBtn.setTitle(LDText(key: "Confirm"))
        
        contentLb.snp.remakeConstraints { make in
            make.bottom.equalTo(confirmBtn.snp.top).offset(-18)
            make.left.equalTo(14)
            make.right.equalTo(-14)
        }
        
        imageView.snp.remakeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(370)
        }
        
        titleLb.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(25)
        }
        
        backBtn.snp.remakeConstraints { make in
            make.width.height.equalTo(52)
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dateClick() {
        self.parentVC().popup.custom(with: LDPopupConfig()) {
            let popup = LDLDVerifyDetailDatePopup(frame: CGRect(x: 0, y: 0, width: 315, height: 460))
            popup.titleLb.text = timestr
            popup.selectedClourse = { date in
                self.dateV?.textTf.text = date
            }
            return popup
        }
    }
    
    override func confirmBtnClick() {
        self.LDShowActivity()
        LDReqManager.request(url: .verifySFZConfirmUrl(params: ["scorer": nameV?.textTf.text ?? "",
                                                                "resulter": IDV?.textTf.text ?? "",
                                                                "foreign": pid,
                                                                "nominee": dateV?.textTf.text ?? ""]), modelType: LDModel.self) { model in
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
    
    func buildItemList(source: [LDVerifyDetailConfirmItemModel]) {
        var topItem: LDLDVerifyDetailConfirmPopupItem?
        
        source.enumerated().forEach { (index, item) in
            let cellItem = LDLDVerifyDetailConfirmPopupItem(frame: CGRectZero)
            cellItem.titleLb.text = item.pmatrix
            cellItem.textTf.text = item.begin
            cellItem.textImg.isHidden = true
            if item.numbers == "scorer" {
                cellItem.textTf.isUserInteractionEnabled = true
                self.nameV = cellItem
            }
            
            if item.numbers == "resulter" {
                timestr = item.pmatrix
                cellItem.textTf.isUserInteractionEnabled = true
                cellItem.textTf.keyboardType = .numberPad
                self.IDV = cellItem
            }
            
            if item.numbers == "nominee" {
                let tap = UITapGestureRecognizer(target: self, action: #selector(dateClick))
                cellItem.textV.addGestureRecognizer(tap)
                self.dateV = cellItem
            }
            
            self.imageView.addSubview(cellItem)
            
            if let _top = topItem {
                if index == source.count - 1 {
                    cellItem.snp.makeConstraints { make in
                        make.horizontalEdges.equalTo(_top)
                        make.top.equalTo(_top.snp.bottom).offset(10)
                        make.bottom.equalTo(confirmBtn.snp.top).offset(-15)
                    }
                } else {
                    cellItem.snp.makeConstraints { make in
                        make.horizontalEdges.equalTo(_top)
                        make.top.equalTo(_top.snp.bottom).offset(10)
                    }
                }
            } else {
                cellItem.snp.makeConstraints { make in
                    make.horizontalEdges.equalToSuperview().inset(15)
                    make.top.equalTo(self.titleLb.snp.bottom).offset(10)
                }
            }
            
            topItem = cellItem
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
