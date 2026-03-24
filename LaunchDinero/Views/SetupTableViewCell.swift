//
//  SetupTableViewCell.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/25.
//

import UIKit

class SetupTableViewCell: UITableViewCell {

    var showVersion: Bool = false {
        didSet {
            self.versionLab.isHidden = !showVersion
            self.arrowImgView.isHidden = showVersion
        }
    }
    
    lazy var bgContainerView: UIView = {
        let bgView = UIView(frame: CGRectZero)
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 20
        bgView.clipsToBounds = true
        return bgView
    }()
    
    lazy var titleLab: UILabel = UILabel(text: "", color: UIColor.black,
                                         font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Regular))
    lazy var versionLab: UILabel = UILabel(text: "V\(LDDevice.info.version)", color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Bold))
    lazy var arrowImgView: UIImageView = UIImageView(image: UIImage(named: "Vector"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.versionLab.isHidden = true
        self.arrowImgView.isHidden = true
        
        self.contentView.addSubview(self.bgContainerView)
        self.bgContainerView.addSubview(self.titleLab)
        self.bgContainerView.addSubview(self.versionLab)
        self.bgContainerView.addSubview(self.arrowImgView)
        
        self.bgContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        
        self.titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(16)
            make.verticalEdges.equalToSuperview().inset(20)
        }
        
        self.versionLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(self.titleLab)
        }
        
        self.arrowImgView.snp.makeConstraints { make in
            make.right.equalTo(self.versionLab)
            make.centerY.equalTo(self.titleLab)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
