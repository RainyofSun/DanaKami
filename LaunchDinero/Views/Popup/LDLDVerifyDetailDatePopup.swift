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
    
    lazy var dayLab: UILabel = UILabel(text: LDText(key: "day"), color: UIColor.black, font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular))
    lazy var monthLab: UILabel = UILabel(text: LDText(key: "month"), color: UIColor.black, font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular))
    lazy var yearLab: UILabel = UILabel(text: LDText(key: "year"), color: UIColor.black, font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular))
    
    lazy var contartView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(hex: "#EEEEEE")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(hex: "#CCCCCC").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
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
        
        contentLb.isHidden = true
        imageView.image = nil
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        backBtn.setImage(UIImage(named: "vertify_pop_close"), for: UIControl.State.normal)
        confirmBtn.setTitle(LDText(key: "Confirm"))
        
        imageView.addSubview(self.contartView)
        self.contartView.addSubview(self.dayLab)
        self.contartView.addSubview(self.monthLab)
        self.contartView.addSubview(self.yearLab)
        self.contartView.addSubview(dp)
        
        imageView.snp.remakeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(390)
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
        
        contartView.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(270)
        }
        
        dayLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        monthLab.snp.makeConstraints { make in
            make.centerY.equalTo(dayLab)
            make.left.equalToSuperview().offset(15)
        }
        
        yearLab.snp.makeConstraints { make in
            make.centerY.equalTo(dayLab)
            make.right.equalToSuperview().offset(-15)
        }
        
        dp.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(5)
            make.top.equalTo(dayLab.snp.bottom)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dp.setTextFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold), textColor: UIColor(hex: "#460629"))
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
