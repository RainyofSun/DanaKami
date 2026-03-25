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

    var addLeftButton: Bool = true {
        didSet {
            if addLeftButton {
                setupLeftBtn()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = LDBgColor
        self.view.addSubview(self.gradientView)
        
        let navConf = UINavigationBarAppearance()
        navConf.configureWithTransparentBackground()
        navConf.backgroundImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navConf
        navigationController?.navigationBar.scrollEdgeAppearance = navConf
        navigationController?.navigationBar.compactAppearance = navConf
        
        self.gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupLeftBtn() {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }

}
