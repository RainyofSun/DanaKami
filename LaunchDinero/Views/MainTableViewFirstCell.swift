//
//  MainTableViewFirstCell.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/23.
//

import UIKit

class MainTableViewFirstCell: UITableViewCell {
    
    var model: LDMainrRamanujanModel = LDMainrRamanujanModel() {
        didSet {
            
            if let _url = URL(string: model.writers) {
                ppLogoImgView.kf.setImage(with: _url, options: [.transition(.fade(0.3))])
            }
            
            ppNameLab.text = model.portal
            mountTip.text = model.southeastern
            amountLab.text = model.telly
            
            dayButton.setTitle(model.female, for: UIControl.State.normal)
            rateButton.setTitle(model.actors, for: UIControl.State.normal)
            
            gradientLoadingButton.setTitle(model.turkish)
        }
    }
    
    lazy var gradientContainerView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.setCorners(.allCorners, radius: 25)
        view.colors = [UIColor.init(hex: "#FFFFFF"), UIColor.init(hex: "#D8D99E")]
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var ppLogoImgView: UIImageView = {
        let view = UIImageView(frame: CGRectZero)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    lazy var ppNameLab: UILabel = UILabel(text: "", color: UIColor.black, font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
    
    lazy var dotView1: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.init(hex: "#FF8844")
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dotView2: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.init(hex: "#C9BDAA")
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dotView3: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.init(hex: "#C9BDAA")
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    lazy var mountTip: UILabel = UILabel(text: "", color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 14, fontStyle: InterFontWeight.Bold))
    lazy var amountLab: UILabel = UILabel(text: "", color: UIColor.init(hex: "#460629"), font: UIFont.interFont(size: 50, fontStyle: InterFontWeight.Extra_Bold))
    lazy var dayButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setTitleColor(UIColor.init(hex: "#460629"), for: UIControl.State.normal)
        view.backgroundColor = UIColor.init(hex: "#C9D9A0")
        view.titleLabel?.font = UIFont.interFont(size: 16, fontStyle: InterFontWeight.Regular)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var rateButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setTitleColor(UIColor.init(hex: "#460629"), for: UIControl.State.normal)
        view.backgroundColor = UIColor.init(hex: "#FFD363")
        view.titleLabel?.font = UIFont.interFont(size: 16, fontStyle: InterFontWeight.Regular)
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var gradientLoadingButton: GradientLoadingButton = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.setFont(UIFont.interFont(size: 20, fontStyle: InterFontWeight.Extra_Bold))
        view.layer.cornerRadius = 27
        view.clipsToBounds = true
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        
        self.contentView.addSubview(self.gradientContainerView)
        self.gradientContainerView.addSubview(self.ppLogoImgView)
        self.gradientContainerView.addSubview(self.ppNameLab)
        self.gradientContainerView.addSubview(self.dotView1)
        self.gradientContainerView.addSubview(self.dotView2)
        self.gradientContainerView.addSubview(self.dotView3)
        self.gradientContainerView.addSubview(self.mountTip)
        self.gradientContainerView.addSubview(self.amountLab)
        self.gradientContainerView.addSubview(self.dayButton)
        self.gradientContainerView.addSubview(self.rateButton)
        self.contentView.addSubview(self.gradientLoadingButton)
        
        self.gradientContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(25)
        }
        
        self.ppLogoImgView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
            make.size.equalTo(30)
        }
        
        self.ppNameLab.snp.makeConstraints { make in
            make.left.equalTo(self.ppLogoImgView.snp.right).offset(10)
            make.centerY.equalTo(self.ppLogoImgView)
        }
        
        self.dotView2.snp.makeConstraints { make in
            make.centerY.equalTo(self.ppLogoImgView)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(8)
        }
        
        self.dotView1.snp.makeConstraints { make in
            make.bottom.equalTo(self.dotView2.snp.top).offset(-4)
            make.size.centerX.equalTo(self.dotView2)
        }
        
        self.dotView3.snp.makeConstraints { make in
            make.top.equalTo(self.dotView2.snp.bottom).offset(4)
            make.size.centerX.equalTo(self.dotView2)
        }
        
        self.mountTip.snp.makeConstraints { make in
            make.left.equalTo(self.ppLogoImgView)
            make.top.equalTo(self.ppLogoImgView.snp.bottom).offset(15)
            make.right.equalTo(self.dotView2)
        }
        
        self.amountLab.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.mountTip)
            make.top.equalTo(self.mountTip.snp.bottom).offset(10)
        }
        
        self.dayButton.snp.makeConstraints { make in
            make.left.equalTo(self.amountLab)
            make.top.equalTo(self.amountLab.snp.bottom).offset(10)
            make.height.equalTo(36)
            make.width.greaterThanOrEqualTo(120)
        }
        
        self.rateButton.snp.makeConstraints { make in
            make.left.equalTo(self.dayButton.snp.right).offset(10)
            make.centerY.height.equalTo(self.dayButton)
            make.width.greaterThanOrEqualTo(120)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        self.gradientLoadingButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.gradientContainerView)
            make.top.equalTo(self.dayButton.snp.bottom).offset(15)
            make.height.equalTo(54)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
