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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgV)
        
        imgV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SceneDelegate().startApp(isWecome: true)
    }

}
