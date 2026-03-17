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
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "login_btn"), for: .normal)
        btn.setTitle(LDText(key: "Next"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
    
    func setupSubviews() {
        
        setupNav(backTitle: navTitle)

        self.view.addSubview(stepV)
        self.view.addSubview(nextBtn)
        
        stepV.snp.makeConstraints { make in
            make.top.equalTo(14 + LDNavMaxY)
            make.left.equalTo(29)
            make.right.equalTo(-29)
        }
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-33)
            make.left.equalTo(32)
            make.right.equalTo(-32)
        }
    }
    
    @objc func nextBtnClick() {
        
    }

}

struct LDVerifyStepModel {
    var img: String = ""
    var selImg: String = ""
    
    init(img: String, selImg: String) {
        self.img = img
        self.selImg = selImg
    }
}

var VerifyStepList: [LDVerifyStepModel] = [LDVerifyStepModel(img: "verify_step_0", selImg: "verify_step_0_sel"),
                                           LDVerifyStepModel(img: "verify_step_1", selImg: "verify_step_1_sel"),
                                           LDVerifyStepModel(img: "verify_step_2", selImg: "verify_step_2_sel"),
                                           LDVerifyStepModel(img: "verify_step_3", selImg: "verify_step_3_sel"),
                                           LDVerifyStepModel(img: "verify_step_4", selImg: "verify_step_4_sel"),
                                           LDVerifyStepModel(img: "verify_step_5", selImg: "verify_step_5_sel"),]

class LDVerifyStepView: UIView {
    
    var index: Int = 0 {
        didSet {
            for (i, imgv) in listImgVs.enumerated() {
                let model = VerifyStepList[i]
                imgv.image = UIImage(named: i > index ? model.img : model.selImg)
            }
            selLineV.snp.remakeConstraints { make in
                make.left.equalTo(itemWH / 2)
                make.height.equalTo(5)
                make.centerY.equalToSuperview()
                make.width.equalTo(CGFloat(index) * (itemWH + margin))
            }
            lineV.snp.remakeConstraints { make in
                make.left.equalTo(selLineV.snp.right)
                make.height.centerY.equalTo(selLineV)
                make.right.equalTo(-itemWH / 2)
            }
        }
    }
    
    var listImgVs: [UIImageView] = []
    
    let itemWH: CGFloat = 37
    
    let margin: CGFloat = (LDScreenWidth - 58 - CGFloat(VerifyStepList.count) * 37) / CGFloat(VerifyStepList.count - 1)
    
    lazy var selLineV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#9BCF21")
        return view
    }()
    
    lazy var lineV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E4FFD4")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(selLineV)
        self.addSubview(lineV)
        
        selLineV.snp.makeConstraints { make in
            make.left.equalTo(itemWH / 2)
            make.height.equalTo(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(0)
        }
        lineV.snp.makeConstraints { make in
            make.left.equalTo(selLineV.snp.right)
            make.height.centerY.equalTo(selLineV)
            make.right.equalTo(-itemWH / 2)
        }
        
        for (i, model) in VerifyStepList.enumerated() {
            let imageView = UIImageView(image: UIImage(named: i > index ? model.img : model.selImg))
            self.addSubview(imageView)
            self.listImgVs.append(imageView)
            
            imageView.snp.makeConstraints { make in
                make.left.equalTo(CGFloat(i) * (itemWH + margin))
                make.top.bottom.equalToSuperview()
                make.width.height.equalTo(itemWH)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
