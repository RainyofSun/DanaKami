//
//  MainTableViewEnglishCell.swift
//  LaunchDinero
//
//  Created by 一刻 on 2026/3/23.
//

import UIKit

protocol EnglishCellProtocol: AnyObject {
    func gotoApply(sender: GradientLoadingButton)
}

class MainTableViewEnglishCell: UITableViewCell {
    
    open weak var eProtocol: EnglishCellProtocol?
    
    lazy var imgContarinerView: UIImageView = UIImageView(image: UIImage(named: "main_cell_bg"))
    lazy var tipLab1: UILabel = UILabel(text: LDText(key: "Loan Terms"), color: .white, font: UIFont.interFont(size: 16, fontStyle: InterFontWeight.Bold))
    lazy var tipLab2: UILabel = UILabel(text: LDText(key: "Click to learn about Loan Terms"), color: .white.withAlphaComponent(0.5), font: UIFont.interFont(size: 12, fontStyle: InterFontWeight.Regular))
    
    lazy var marksButton: GradientLoadingButton = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.setTitle(LDText(key: "Check"))
        view.setTitleColor(UIColor.init(hex: "#460629"))
        view.setGradientColors([UIColor.init(hex: "#FBF5DE"), UIColor.init(hex: "#FBF5DE")])
        view.setFont(UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
        view.layer.cornerRadius = 17
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(clickMaskButton(sender: )), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    lazy var gradingContainerView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.verticalGradient([UIColor.white, UIColor.init(hex: "#D8D99E")])
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
        
        self.imgContarinerView.isUserInteractionEnabled = true
        
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
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview()
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
            make.height.equalTo(34)
        }
        
        self.gradingContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.tipLab2.snp.bottom).offset(20)
            make.height.greaterThanOrEqualTo(240)
            make.bottom.equalToSuperview()
        }
        
        self.tipLab3.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab1)
            make.top.equalToSuperview().offset(15)
        }
        
        self.leftGradientView.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab3)
            make.height.equalTo((LDScreenWidth - 45) * 0.225)
            make.top.equalTo(self.tipLab3.snp.bottom).offset(15)
        }
        
        self.rightGradientView.snp.makeConstraints { make in
            make.left.equalTo(self.leftGradientView.snp.right).offset(15)
            make.verticalEdges.width.equalTo(self.leftGradientView)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.leftImgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.rightImgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.tipLab4.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab3)
            make.top.equalTo(self.leftGradientView.snp.bottom).offset(20)
        }
        
        self.whiteConterView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(self.tipLab4.snp.bottom).offset(10)
        }
        
        self.topItem.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        self.midItem.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.topItem)
            make.top.equalTo(self.topItem.snp.bottom)
        }
        
        self.bottomItem.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.midItem)
            make.top.equalTo(self.midItem.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.tipLab5.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab4)
            make.top.equalTo(self.whiteConterView.snp.bottom).offset(20)
        }
        
        self.midImgView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(self.tipLab5.snp.bottom).offset(10)
            make.height.equalTo((LDScreenWidth - 60) * 0.32)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    @objc func clickMaskButton(sender: GradientLoadingButton) {
        self.eProtocol?.gotoApply(sender: sender)
    }
}
