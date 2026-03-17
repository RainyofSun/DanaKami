//
//  LDVerifyDetailATextCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import UIKit

class LDVerifyDetailATextCell: LDCell, UITextFieldDelegate {
    
    var endEditingClourse: ((_ text: String) -> Void)?
    
    var model: LDVerifyDetailAItemModel = LDVerifyDetailAItemModel() {
        didSet {
            titleLb.text = model.rainmaker
            tf.placeholder = model.association
            tf.text = model.choice
            tf.keyboardType = model.cinema == 1 ? .numberPad : .default
        }
    }
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "")
        return lb
    }()
    
    lazy var tf: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 14)
        tf.textColor = UIColor(hex: "#333333")
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 46))
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 46))
        tf.backgroundColor = .white
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 12
        tf.delegate = self
        return tf
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(titleLb)
        self.contentView.addSubview(tf)
        
        titleLb.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.height.equalTo(22)
        }
        tf.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(46)
            make.bottom.equalTo(-16)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endEditingClourse?(textField.text ?? "")
    }

}
