//
//  MainTableViewEnglishCell.swift
//  LaunchDinero
//
//  Created by 一刻 on 2026/3/23.
//

import UIKit

class MainTableViewEnglishCell: UITableViewCell {
    
    lazy var imgContarinerView: UIImageView = UIImageView(image: UIImage(named: "main_cell_bg"))
    lazy var tipLab1: UILabel = UILabel(text: LDText(key: "Loan Terms"), color: .white, font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
    lazy var tipLab2: UILabel = UILabel(text: LDText(key: "Click to learn about Loan Terms"), color: .white.withAlphaComponent(0.5), font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Regular))
    
    lazy var marksButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setTitle(LDText(key: "Check"), for: UIControl.State.normal)
        view.setTitleColor(UIColor.init(hex: "#460629"), for: UIControl.State.normal)
        view.backgroundColor = UIColor.init(hex: "#FBF5DE")
        view.titleLabel?.font = UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    lazy var gradingContainerView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.colors = [UIColor.white, UIColor.init(hex: "#D8D99E")]
        view.setCorners([.topLeft, .topRight], radius: 25)
        return view
    }()
    
    lazy var tipLab3: UILabel = UILabel(text: LDText(key: "Legitimate licensed institutions"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
    lazy var leftGradientView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.diagonalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        view.setCorners(.allCorners, radius: 25)
        return view
    }()
    
    lazy var leftImgView: UIImageView = UIImageView(image: UIImage(named: "main_left"))
    
    lazy var rightGradientView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.diagonalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
        view.setCorners(.allCorners, radius: 25)
        return view
    }()
    
    lazy var rightImgView: UIImageView = UIImageView(image: UIImage(named: "main_right"))
    
    lazy var tipLab4: UILabel = UILabel(text: LDText(key: "Product advantages"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
    lazy var whiteConterView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = .white.withAlphaComponent(0.6)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    lazy var topItem: MainTableViewEnglishCellItem = MainTableViewEnglishCellItem(frame: CGRectZero, itemType: MainTableViewEnglishCellItemType.Top)
    lazy var midItem: MainTableViewEnglishCellItem = MainTableViewEnglishCellItem(frame: CGRectZero, itemType: MainTableViewEnglishCellItemType.Mid)
    lazy var bottomItem: MainTableViewEnglishCellItem = MainTableViewEnglishCellItem(frame: CGRectZero, itemType: MainTableViewEnglishCellItemType.Bottom)
    
    lazy var tipLab5: UILabel = UILabel(text: LDText(key: "Steps to obtain a loan"), color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
    lazy var midImgView: UIImageView = UIImageView(image: UIImage(named: isEnglish ? "main_en_ll" : "main_es_ll"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.imgContarinerView)
        self.imgContarinerView.addSubview(self.tipLab1)
        self.imgContarinerView.addSubview(self.tipLab2)
        self.imgContarinerView.addSubview(self.marksButton)
        self.contentView.addSubview(self.gradingContainerView)
        self.gradingContainerView.addSubview(self.tipLab3)
        self.gradingContainerView.addSubview(self.leftGradientView)
        self.leftGradientView.addSubview(self.leftImgView)
        self.gradingContainerView.addSubview(self.rightGradientView)
        self.rightGradientView.addSubview(self.rightImgView)
        self.gradingContainerView.addSubview(self.tipLab4)
        self.gradingContainerView.addSubview(self.whiteConterView)
        self.whiteConterView.addSubview(self.topItem)
        self.whiteConterView.addSubview(self.midItem)
        self.whiteConterView.addSubview(self.bottomItem)
        self.gradingContainerView.addSubview(self.tipLab5)
        self.gradingContainerView.addSubview(self.midImgView)
        
        self.imgContarinerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(LDScreenWidth * 0.27)
        }
        
        self.tipLab1.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(15)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        self.tipLab2.snp.makeConstraints { make in
            make.top.equalTo(self.tipLab1.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(self.tipLab1)
        }
        
        self.marksButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.tipLab1)
            make.width.greaterThanOrEqualTo(80)
            make.width.lessThanOrEqualTo(120)
        }
        
        self.gradingContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.tipLab2.snp.bottom).offset(20)
        }
        
        self.tipLab3.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab1)
            make.top.equalToSuperview().offset(15)
        }
        
        self.leftGradientView.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab3)
            make.top.equalTo(self.tipLab3.snp.bottom).offset(15)
        }
        
        self.rightGradientView.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
