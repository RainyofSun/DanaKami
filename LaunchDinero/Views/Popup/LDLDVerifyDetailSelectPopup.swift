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
        
        contentLb.isHidden = true
        imageView.image = nil
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        backBtn.setImage(UIImage(named: "vertify_pop_close"), for: UIControl.State.normal)
        confirmBtn.setTitle(LDText(key: "Confirm"))
        
        imageView.addSubview(selectView)
        
        imageView.snp.remakeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(330)
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(text: list[safe: row]?.scorer ?? "", color: (selectedIndex == row ? UIColor.init(hex: "#460629") : UIColor.black), font: (selectedIndex == row ? UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold) : UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular)), alignment: .center)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        pickerView.reloadAllComponents()
    }
    
}
