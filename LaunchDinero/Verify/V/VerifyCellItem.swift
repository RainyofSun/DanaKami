//
//  VerifyCellItem.swift
//  LaunchDinero
//
//  Created by 一刻 on 2026/3/26.
//

import UIKit

class VerifyCellItem: UIControl {

    lazy var iconImgView: UIImageView = {
        let view = UIImageView(frame: CGRectZero)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.iconImgView)
        self.addSubview(self.titleLb)
        self.addSubview(self.arrowImg)
        
        self.iconImgView.snp.makeConstraints { make in
            make.size.equalTo(42)
            make.left.equalToSuperview().offset(8)
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        self.titleLb.snp.makeConstraints { make in
            make.centerY.equalTo(iconImgView)
            make.left.equalTo(iconImgView.snp.right).offset(8)
        }
        
        self.arrowImg.snp.makeConstraints { make in
            make.centerY.equalTo(self.iconImgView)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(34)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            arrowImg.image = UIImage(named: !isSelected ? "Vector" : "login_yes")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
