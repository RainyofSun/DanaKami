//
//  LDBaseVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDBaseVC: UIViewController {
    
    var beginTime: String = ""
    
    lazy var navView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = LDBgColor
        
        let navConf = UINavigationBarAppearance()
        navConf.configureWithTransparentBackground()
        navConf.backgroundImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navConf
        navigationController?.navigationBar.scrollEdgeAppearance = navConf
        navigationController?.navigationBar.compactAppearance = navConf
    }
    
    func setupNav(backTitle: String) {
        
        setupLeftBtn(backTitle: backTitle)
        
        self.view.addSubview(navView)
        
        navView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(LDNavMaxY)
        }
    }
    
    func setupLeftBtn(backTitle: String) {
        let btn = UIButton(type: .custom)
        btn.setTitle(backTitle, for: .normal)
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
