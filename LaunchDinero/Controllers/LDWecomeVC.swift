//
//  LDWecomeVC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/24.
//

import UIKit

class LDWecomeVC: LDBaseVC {
    
    lazy var imgV: UIImageView = {
        let img = UIImageView(image: UIImage(named: "wecome"))
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var applogoImgView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "appLogo"))
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgV)
        imgV.addSubview(applogoImgView)
        
        imgV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        applogoImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SceneDelegate().startApp(isWecome: true)
    }

}
