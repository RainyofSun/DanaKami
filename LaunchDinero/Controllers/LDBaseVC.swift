//
//  LDBaseVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDBaseVC: UIViewController {
    
    var beginTime: String = ""
    
    var gradientView: GradientView = {
        let view = GradientView(frame: CGRectZero)
        view.diagonalGradient([UIColor(hex: "#C7C58B"), UIColor(hex: "#CFC98A")])
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = LDBgColor
        self.view.addSubview(self.gradientView)
        
        self.gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
