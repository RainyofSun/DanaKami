//
//  LDVerifyListCell.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/20.
//

import UIKit

class LDVerifyListCell: LDCell {
    
    var model: LDVerifyPromisingModel = LDVerifyPromisingModel() {
        didSet {
            titleLb.text = model.rainmaker
            pointV.backgroundColor = model.society == 0 ? UIColor(hex: "#9BCF21") : UIColor(hex: "#173100")
            arrowImg.image = UIImage(named: model.society == 0 ? "verify_list_arrow" : "verify_list_finish")
        }
    }
    
    lazy var pointV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#9BCF21")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hex: "#173100").cgColor
        return view
    }()
    
    lazy var arrowImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "verify_list_arrow"))
        return img
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel(text: "Información del trabajo",
                         color: UIColor(hex: "#3D3D3D"),
                         font: .systemFont(ofSize: 15))
        lb.numberOfLines = 0
        return lb
    }()

    override func setupSubviews() {
        super.setupSubviews()
        
        self.contentView.addSubview(pointV)
        self.contentView.addSubview(bgView)
        bgView.addSubview(arrowImg)
        bgView.addSubview(titleLb)
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(39)
            make.right.equalTo(-14)
            make.top.equalToSuperview()
            make.bottom.equalTo(-12)
            make.height.equalTo(54)
        }
        pointV.snp.makeConstraints { make in
            make.centerY.equalTo(bgView)
            make.right.equalTo(bgView.snp.left).offset(-12)
            make.width.height.equalTo(10)
        }
        arrowImg.snp.makeConstraints { make in
            make.right.equalTo(-14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
        }
        titleLb.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(arrowImg.snp.left).offset(-14)
        }
    }

}
