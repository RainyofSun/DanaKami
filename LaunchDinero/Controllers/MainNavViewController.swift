//
//  MainNavViewController.swift
//  LaunchDinero
//
//  Created by 一刻 on 2026/3/26.
//

import UIKit

class MainNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.navigationAppearanceSetting()
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !self.children.isEmpty {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            
        }
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        super.pushViewController(viewController, animated: animated)
    }

}

protocol AutoHiddenNavigationBar where Self: UIViewController {
    
}

extension MainNavViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is AutoHiddenNavigationBar {
            self.setNavigationBarHidden(true, animated: true)
        } else {
            self.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension MainNavViewController: UINavigationBarDelegate {
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if self.viewControllers.count < navigationBar.items?.count ?? 1 {
            return true
        }
        
        var currentPageCanPop = true
        if let c_v = self.topViewController {
            currentPageCanPop = c_v.shouldPop()
        }
        
        if currentPageCanPop {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            for subview in navigationBar.subviews
            {
                if (0.0 < subview.alpha && subview.alpha < 1.0) {
                    UIView.animate(withDuration: 0.25, animations: {
                        subview.alpha = 1.0
                    })
                }
            }
        }
        
        return false
    }
}

private extension MainNavViewController {
    func navigationAppearanceSetting() {
        let appearance = UINavigationBarAppearance()
        let att = [NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#FFFFFF"),
                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        let gabbroidImage = UIImage(systemName: "chevron.backward")
        let qarnnsImage = gabbroidImage?.withTintColor(UIColor.init(hex: "#27272E"), renderingMode: .alwaysOriginal)
        appearance.configureWithTransparentBackground() // 关键：透明背景
        appearance.backgroundColor = .clear        // 设置背景色
        appearance.shadowColor = .clear
        appearance.backgroundImage = UIImage()
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.tintColor = UIColor.init(hex: "#27272E")
        self.navigationBar.backIndicatorImage = qarnnsImage
        self.navigationBar.backIndicatorTransitionMaskImage = qarnnsImage
        self.navigationBar.shadowImage = barShadowImage()
        self.navigationBar.titleTextAttributes = att
    }
    
    func barShadowImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: LDScreenWidth, height: 0.5), false, 0)
        let path = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: LDScreenWidth, height: 0.5))
        UIColor.clear.setFill()// 自定义NavigationBar分割线颜色
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
