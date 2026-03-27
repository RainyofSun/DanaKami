//
//  LDVerifyDetailBPopup.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailBPopup: LDPopupView {
    
    var isFirst: Bool = true {
        didSet {
            if isFirst {
                img.image = isEnglish ? UIImage(named: "vertify_front_pop_en") : UIImage(named: "vertify_front_pop_id")
            } else {
                img.image = isEnglish ? UIImage(named: "vertify_back_pop_en") : UIImage(named: "vertify_back_pop_id")
            }
        }
    }
    
    lazy var img: UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentLb.isHidden = true
        backBtn.setImage(UIImage(named: "vertify_pop_close"), for: UIControl.State.normal)
        imageView.image = nil
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        confirmBtn.setImage(UIImage(named: "pop_camera"))
        confirmBtn.setTitle(LDText(key: "Camera"))
        
        self.addSubview(img)
        
        imageView.snp.remakeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(370)
        }
        
        titleLb.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(25)
        }
        
        img.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
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
}
