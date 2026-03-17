//
//  LDTools.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import Foundation
import SnapKit
import Kingfisher
import JFPopup
import ESPullToRefresh

let LDScreenHeight: CGFloat = UIScreen.main.bounds.height
let LDScreenWidth: CGFloat = UIScreen.main.bounds.width
var LDStatusBarHeight: CGFloat {
    if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        return ws.statusBarManager?.statusBarFrame.height ?? 20.0
    } else {
        return 20.0
    }
}
let LDNavHeight: CGFloat = 44.0
let LDNavMaxY: CGFloat = LDNavHeight + LDStatusBarHeight
let LDTabBarHeight: CGFloat = 49.0
var LDHomeBarHeight: CGFloat {
    if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = ws.windows.first {
        return window.safeAreaInsets.bottom
    } else {
        return 0
    }
}

let isiPhoneX: Bool = LDHomeBarHeight <= 0

let LDScale: CGFloat = LDScreenWidth / 375

let LDBgColor = UIColor(hex: "#F5F5F5")

let LDUserDefaultKey_SID: String = "LDUserDefaultKey_SID"
let LDUserDefaultKey_CITY: String = "LDUserDefaultKey_CITY"
let LDUserDefaultKey_IDFA: String = "LDUserDefaultKey_IDFA"
let LDUserDefaultKey_IDFV: String = "LDUserDefaultKey_IDFV"
let LDUserDefaultKey_OneDay: String = "LDUserDefaultKey_OneDay"

func LDNowTime() -> String {
    return "\(Int(Date().timeIntervalSince1970))"
}

func isLogin(currentVC: UIViewController) -> Bool {
    guard let sID = UserDefaults.standard.string(forKey: LDUserDefaultKey_SID), sID.count > 0 else {
        let vc = LDLoginVC()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        currentVC.present(vc, animated: true)
        return false
    }
    return true
}

func allowProductDetail(vc: UIViewController, pID: String) {
    vc.view.LDShowActivity()
    LDPermissionManager.location { isAllow in
        if !isAllow && isGreaterThanOneDay() && LDLocalLanguage.shared.localLanguage == .es {
            vc.view.LDHideActivity()
            LDPermissionManager.requestPermission(currentVC: vc)
        } else {
            LDReqManager.request(url: .allowProductUrl(params: ["foreign": pID]), modelType: LDAllowProductModel.self) { model in
                vc.view.LDHideActivity()
                switch model {
                case .success(let success):
                    if let m = success.financial {
                        if m.domestic == 200 {
                            jumpPage(vc: vc, url: m.infinity)
                        } else {
                            vc.view.LDToast(text: m.sound)
                        }
                    } else {
                        vc.view.LDToast(text: success.information)
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
}

func jumpPage(vc: UIViewController, url: String) {
    if url.hasPrefix("http") {
        let viewController = LDHTMLVC()
        viewController.webUrl = url
        viewController.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(viewController, animated: true)
    } else {
        if url.contains("fleck") { // setting
            let viewController = LDSetupVC()
            viewController.hidesBottomBarWhenPushed = true
            vc.navigationController?.pushViewController(viewController, animated: true)
        } else if url.contains("etrieved") { // main
            if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene, let w = ws.windows.first {
                w.rootViewController = LDTabBarC()
            }
        } else if url.contains("llywood") { // login
            if isLogin(currentVC: vc) {
                
            }
        } else if url.contains("vemb") { // order
            if let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene, let w = ws.windows.first {
                w.rootViewController = LDTabBarC(index: 1)
            }
        } else if url.contains("full") { // productDetail
            let list = url.components(separatedBy: "foreign=")
            if let pID = list[safe: 1] {
                let viewControll = LDVerifyListVC()
                viewControll.pID = pID
                viewControll.hidesBottomBarWhenPushed = true
                vc.navigationController?.pushViewController(viewControll, animated: true)
            }
        }
    }
}

func dateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyy"
    return dateFormatter
}

func isGreaterThanOneDay() -> Bool {
    let nowTime = Date().timeIntervalSince1970
    if let time = UserDefaults.standard.object(forKey: LDUserDefaultKey_OneDay) as? TimeInterval {
        if nowTime - time > 86400 {
            UserDefaults.standard.set(nowTime, forKey: LDUserDefaultKey_OneDay)
            return true
        } else {
            return false
        }
    }
    UserDefaults.standard.set(nowTime, forKey: LDUserDefaultKey_OneDay)
    return true
}

func getBaseUrl(urls: [String], index: Int = 0) {
    guard index < urls.count else {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
            window.rootViewController = LDWecomeVC()
        }
        return
    }
    LDUrl = urls[index]
    LDReqManager.request(url: .firstUrl, modelType: LDStartModel.self) { result in
        switch result {
        case .success(let success):
            if let m = success.financial {
                startModel = m
                LDLocalLanguage.shared.configLanguage(type: startModel.retrieved == 2 ? .es : .en)
                UserDefaults.standard.set(startModel.retrieved, forKey: LDUserDefaultKey_CITY)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
                    window.rootViewController = LDTabBarC()
                    window.makeKeyAndVisible()
                }
                return
            } else {
                getBaseUrl(urls: urls, index: index + 1)
            }
        case .failure(_):
            getBaseUrl(urls: urls, index: index + 1)
        }
    }
}
