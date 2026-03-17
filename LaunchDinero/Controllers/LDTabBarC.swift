//
//  LDTabBarC.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit

class LDTabBarC: UITabBarController {
    
    var vcs: [UIViewController] = [
        UINavigationController(rootViewController: LDMainVC()),
        UINavigationController(rootViewController: LDListVC()),
        UINavigationController(rootViewController: LDUserVC()),
    ]
    
    convenience init(index: Int) {
        self.init()
        self.selectedIndex = index
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.backgroundColor = .white
        setupTabBarSubViews()
        self.delegate = self
    }
    

    func setupTabBarSubViews() {
        viewControllers = vcs
        
        let noImages: [String] = ["tb_icon_1_no", "tb_icon_2_no", "tb_icon_3_no"]
        let yesImages: [String] = ["tb_icon_1_yes", "tb_icon_2_yes", "tb_icon_3_yes"]
        
        for(index, vc) in vcs.enumerated() {
            vc.tabBarItem = UITabBarItem(title: "",
                                         image: UIImage(named: noImages[index])?.withRenderingMode(.alwaysOriginal),
                                         selectedImage: UIImage(named: yesImages[index])?.withRenderingMode(.alwaysOriginal))
        }
    }

}

extension LDTabBarC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard isLogin(currentVC: self) else {
            return false
        }
        return true
    }
}
