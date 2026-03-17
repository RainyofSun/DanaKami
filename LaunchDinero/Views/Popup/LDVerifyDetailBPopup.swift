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
            img.image = UIImage(named: isFirst ? "popup_verify_photo_1_img" : "popup_verify_photo_2_img")
            
            let thumb1: [String] = ["popup_verify_photo_1_1", "popup_verify_photo_1_2", "popup_verify_photo_1_3"]
            let thumb2: [String] = ["popup_verify_photo_2_1", "popup_verify_photo_2_2", "popup_verify_photo_2_3"]
            
            for (i, thumb) in thumbList.enumerated() {
                thumb.image = UIImage(named: isFirst ? thumb1[i] : thumb2[i])
            }
        }
    }
    
    var thumbList: [UIImageView] = []
    var thumbW: CGFloat = 81
    var thumbH: CGFloat = 67
    
    lazy var img: UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    
    lazy var subtitleLb: UILabel = {
        let lb = UILabel(text: "Wrong demonstration",
                         font: .systemFont(ofSize: 14),
                         alignment: .center)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = UIImage(named: "popup_verify_photo")
        titleLb.text = LDText(key: "Demonstration")
        contentLb.textColor = UIColor(hex: "#E31C1C")
        contentLb.text = LDText(key: "Verify upload photo hint")
        contentLb.font = .systemFont(ofSize: 13)
        
        self.addSubview(img)
        self.addSubview(subtitleLb)
        
        img.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        subtitleLb.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        for i in 0..<3 {
            let thumb = UIImageView(image: UIImage(named: ""))
            self.addSubview(thumb)
            thumbList.append(thumb)
            
            thumb.snp.makeConstraints { make in
                make.top.equalTo(subtitleLb.snp.bottom).offset(10)
                if i == 0 {
                    make.left.equalTo(img)
                } else if i == 1 {
                    make.centerX.equalTo(img)
                } else {
                    make.right.equalTo(img)
                }
                make.width.equalTo(thumbW)
                make.height.equalTo(thumbH)
            }
        }
        
        contentLb.snp.remakeConstraints { make in
            make.bottom.equalTo(confirmBtn.snp.top).offset(-20)
            make.left.equalTo(28)
            make.right.equalTo(-28)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
