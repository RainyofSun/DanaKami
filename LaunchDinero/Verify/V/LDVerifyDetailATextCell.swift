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
            tf.attributedPlaceholder = NSMutableAttributedString(string: model.association, attributes: [.foregroundColor: UIColor.init(hex: "#999999"), .font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold)])
            tf.text = model.choice
            tf.keyboardType = model.cinema == 1 ? .numberPad : .default
        }
    }
    
    lazy var containerView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(hex: "#EEEEEE").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "", color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular))
        return lb
    }()
    
    lazy var tf: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold)
        tf.textColor = UIColor(hex: "#333333")
        tf.backgroundColor = .white
        tf.delegate = self
        return tf
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(titleLb)
        self.containerView.addSubview(tf)
        
        self.containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        
        titleLb.snp.makeConstraints { make in
            make.top.left.equalTo(15)
            make.height.equalTo(22)
        }
        
        tf.snp.makeConstraints { make in
            make.top.equalTo(titleLb.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(46)
            make.bottom.equalTo(-15)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endEditingClourse?(textField.text ?? "")
    }

}
