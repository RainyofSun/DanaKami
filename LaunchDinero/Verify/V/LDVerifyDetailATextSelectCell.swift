//
//  LDVerifyDetailATextSelectCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/3/5.
//

import UIKit

class LDVerifyDetailATextSelectCell: LDVerifyDetailATextCell {
    
    var selectedClourse:(() -> Void)?
    
    override var model: LDVerifyDetailAItemModel {
        didSet {
            titleLb.text = model.rainmaker
            tf.placeholder = model.association
            tf.text = ""
            if model.editors == "supportingc" {
                tf.text = model.choice
            } else {
                for item in model.lyrics {
                    if "\(item.listed)" == model.choice {
                        tf.text = item.scorer
                    }
                }
            }
        }
    }
    
    lazy var selBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(selBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var arrowImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "verify_list_arrow"))
        img.isUserInteractionEnabled = true
        return img
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(arrowImg)
        self.contentView.addSubview(selBtn)
        
        selBtn.snp.makeConstraints { make in
            make.edges.equalTo(tf)
        }
        arrowImg.snp.makeConstraints { make in
            make.right.equalTo(tf).offset(-14)
            make.centerY.equalTo(tf)
        }
    }
    
    @objc func selBtnClick() {
        selectedClourse?()
    }

}
