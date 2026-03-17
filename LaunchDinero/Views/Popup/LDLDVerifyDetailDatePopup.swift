//
//  LDLDVerifyDetailDatePopup.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDLDVerifyDetailDatePopup: LDPopupView {
    
    var selectedStr: String = ""
    
    var selectedClourse: ((_ date: String) -> Void)?
    
    lazy var dp: UIDatePicker = {
        let dp = UIDatePicker()
        dp.backgroundColor = .clear
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        dp.addTarget(self, action: #selector(selectedDate), for: .valueChanged)
        return dp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = UIImage(named: "popup_select")
        contentLb.isHidden = true
        
        self.addSubview(dp)
        
        dp.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(14)
            make.left.equalTo(27)
            make.right.equalTo(-27)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectedDate() {
        selectedStr = dateFormatter().string(from: dp.date)
    }
    
    override func confirmBtnClick() {
        super.confirmBtnClick()
        
        selectedClourse?(selectedStr)
    }
    
}
