//
//  MainTableViewLastCell.swift
//  LaunchDinero
//
//  Created by Yu Chen  on 2026/3/23.
//

import UIKit

class MainTableViewLastCell: UITableViewCell {

    lazy var imgContarinerView: UIImageView = UIImageView(frame: CGRectZero)
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
    
    lazy var contentImgView: UIImageView = UIImageView(image: UIImage(named: ""))
}
