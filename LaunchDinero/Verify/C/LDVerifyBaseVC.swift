//
//  LDVerifyBaseVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/20.
//

import UIKit

class LDVerifyBaseVC: LDBaseVC {
    
    /// Product id
    var pID: String = ""
    
    /// OrderNo
    var OrderNo: String = ""
    
    var navTitle: String = ""
    
    lazy var stepV: LDVerifyStepView = {
        let view = LDVerifyStepView(frame: .zero)
        return view
    }()
    
    lazy var nextBgView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var nextBtn: GradientLoadingButton = {
        let btn = GradientLoadingButton(frame: CGRectZero)
        btn.layer.cornerRadius = 22
        btn.clipsToBounds = true
        btn.setTitle(LDText(key: "Next"))
        btn.setTitleColor(.white)
        btn.setFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        btn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var cornerBgView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.verticalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        view.setCorners([.topLeft, .topRight], radius: 25)
        return view
    }()
    
    lazy var tipView: VertifyBTipView = VertifyBTipView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
    
    func setupSubviews() {

        self.view.addSubview(stepV)
        self.view.addSubview(self.cornerBgView)
        self.cornerBgView.addSubview(self.tipView)
        self.cornerBgView.addSubview(self.nextBgView)
        self.nextBgView.addSubview(nextBtn)
        
        stepV.snp.makeConstraints { make in
            make.top.equalTo(20 + LDNavMaxY)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo((LDScreenWidth - 30) * 0.17)
        }
        
        cornerBgView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(stepV.snp.bottom).offset(15)
        }
        
        tipView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(15)
            make.height.greaterThanOrEqualTo(36)
        }
        
        nextBgView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        nextBtn.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(44)
        }
    }
    
    @objc func nextBtnClick() {
        
    }

}

struct LDVerifyStepModel {
    var img: String = ""
    var tipStr: String = ""
    
    init(img: String, tipStr: String) {
        self.img = img
        self.tipStr = tipStr
    }
}

var VerifyStepList: [LDVerifyStepModel] = [LDVerifyStepModel(img: "step1", tipStr: "Verify upload photo hint"),
                                           LDVerifyStepModel(img: "step2", tipStr: "Verify upload photo hint"),
                                           LDVerifyStepModel(img: "step3", tipStr: "Verify upload photo hint"),
                                           LDVerifyStepModel(img: "step4", tipStr: "Verify upload photo hint"),
                                           LDVerifyStepModel(img: "step5", tipStr: "Verify upload photo hint"),]

class LDVerifyStepView: UIImageView {
    
    var index: Int = 0 {
        didSet {
            self.image = UIImage(named: VerifyStepList[index].img)
        }
    }
}
