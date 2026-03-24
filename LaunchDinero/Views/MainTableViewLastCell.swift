//
//  MainTableViewLastCell.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/23.
//

import UIKit

class MainTableViewLastCell: UITableViewCell {

    open weak var eProtocol: EnglishCellProtocol?
    
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
        view.addTarget(self, action: #selector(clickMaskButton(sender: )), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    lazy var gradingContainerView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.colors = [UIColor.white, UIColor.init(hex: "#D8D99E")]
        view.setCorners([.topLeft, .topRight], radius: 25)
        return view
    }()
    
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
        
        self.tipLab5.snp.makeConstraints { make in
            make.left.equalTo(self.tipLab1)
            make.top.equalToSuperview().offset(15)
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
