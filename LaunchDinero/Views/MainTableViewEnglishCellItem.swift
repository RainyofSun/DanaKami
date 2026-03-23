//
//  MainTableViewEnglishCellItem.swift
//  LaunchDinero
//
//  Created by 一刻 on 2026/3/23.
//

import UIKit

enum MainTableViewEnglishCellItemType {
    case Top
    case Mid
    case Bottom
    
    func getTextKey() -> (String, String, String) {
        switch self {
        case .Top:
            return ("main_top", "Flexible credit limit", "Revolving credit is available; borrow and repay at any time.")
        case .Mid:
            return ("main_mid", "Efficient approval", "Fully automated intelligent approval, results in as little as 1 minute.")
        case .Bottom:
            return ("main_bottom", "transparent interest and fees", "Interest and fee information is clearly available, with no hidden charges.")
        }
    }
}

class MainTableViewEnglishCellItem: UIView {

    lazy var avatarImgView: UIImageView = UIImageView(frame: CGRectZero)
    lazy var tipLab1: UILabel = UILabel(text: "", color: UIColor.black, font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
    lazy var tipLab2: UILabel = UILabel(text: "", color: UIColor.init(hex: "#666666"), font: UIFont.interFont(size: 11, fontStyle: InterFontWeight.Regular))
    
    init(frame: CGRect, itemType: MainTableViewEnglishCellItemType) {
        super.init(frame: frame)
        
        self.tipLab2.numberOfLines = 0
        
        self.avatarImgView.image = UIImage(named: itemType.getTextKey().0)
        self.tipLab1.text = LDText(key: itemType.getTextKey().1)
        self.tipLab2.text = LDText(key: itemType.getTextKey().2)
        
        self.addSubview(self.avatarImgView)
        self.addSubview(self.tipLab1)
        self.addSubview(self.tipLab2)
        
        self.avatarImgView.snp.makeConstraints { make in
            make.size.equalTo(54)
            make.left.equalToSuperview().offset(15)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        
        self.tipLab1.snp.makeConstraints { make in
            make.top.equalTo(self.avatarImgView)
            make.left.equalTo(self.avatarImgView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.tipLab2.snp.makeConstraints { make in
            make.top.equalTo(self.tipLab1.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(self.tipLab1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
