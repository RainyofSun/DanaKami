//
//  LDLDVerifyDetailSelectPopup.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import UIKit

class LDLDVerifyDetailSelectPopup: LDPopupView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var list: [LDVerifyDetailCLyricsModel] = []
    
    var selectedIndex: Int = 0
    
    var selectedClourse: ((_ index: Int) -> Void)?
    
    lazy var selectView: UIPickerView = {
        let view = UIPickerView()
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = UIImage(named: "popup_select")
        contentLb.isHidden = true
        
        self.addSubview(selectView)
        
        selectView.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(14)
            make.left.equalTo(27)
            make.right.equalTo(-27)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func confirmBtnClick() {
        super.confirmBtnClick()
        selectedClourse?(selectedIndex)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let m = list[safe: row] {
            return m.scorer
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
}
