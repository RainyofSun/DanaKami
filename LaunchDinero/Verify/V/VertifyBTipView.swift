//
//  VertifyBTipView.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/27.
//

import UIKit

class VertifyBTipView: UIView {

    lazy var tipImgView: UIImageView = UIImageView(image: UIImage(named: "vertifyBtip"))
    lazy var tiptextLab: UILabel = UILabel(text: LDText(key: "Verify upload photo hint"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 10, fontStyle: InterFontWeight.Regular))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tiptextLab.numberOfLines = 0
        
        self.backgroundColor = UIColor.init(hex: "#FFD363")
        self.clipsToBounds = true
        
        self.addSubview(self.tipImgView)
        self.addSubview(self.tiptextLab)
        
        self.tipImgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(16)
        }
        
        self.tiptextLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.tipImgView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.jf_height/2
    }
}
