//
//  SceneDelegate.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager
import IQKeyboardToolbar
import JFPopup
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardToolbarManager.shared.toolbarConfiguration.doneBarButtonConfiguration = IQBarButtonItemConfiguration(title: "Done")
        IQKeyboardToolbarManager.shared.toolbarConfiguration.manageBehavior = .byTag
        IQKeyboardToolbarManager.shared.toolbarConfiguration.previousNextDisplayMode = .alwaysHide
        IQKeyboardToolbarManager.shared.enabledToolbarClasses.append(LDVerifyBaseVC.self)
        IQKeyboardToolbarManager.shared.enabledToolbarClasses.append(LDLoginVC.self)
        IQKeyboardToolbarManager.shared.enabledToolbarClasses.append(JFPopupController.self)
        
        if UIDevice.isIpad() || isSimulator() {
            LDLocalLanguage.shared.configLanguage(type: .en)
            UserDefaults.standard.set("1", forKey: LDUserDefaultKey_CITY)
            self.window?.rootViewController = LDTabBarC()
            self.window?.makeKeyAndVisible()
        } else {
            setWelcomeVC()
        }
    }
    
    func isSimulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    func startApp(isWecome: Bool = false) {
        if UIDevice.isIpad() || isSimulator() {
            return
        }
        
        if isWecome, let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            self.window = ws.windows.first
        }
        self.window?.LDShowActivity()
        
        LDReqManager.request(url: LDReqURL.firstUrl(params: ["timer": Locale.preferredLanguages.first ?? "en", "mojo": (LDDevice.isVPNConnected() ? 1 : 0), "movies": LDDevice.proxyInfo().enabled ? 1 : 0]), modelType: LDStartModel.self) { result in
            self.window?.LDHideActivity()
            switch result {
            case .success(let success):
                if let m = success.financial {
                    startModel = m
                    // TODO 测试使用
                    #if DEBUG
                    startModel.retrieved = "2"
                    #else
                    FacebookChuShiHua(startModel.catalog)
                    #endif
                    
                    LDLocalLanguage.shared.configLanguage(type: startModel.retrieved == "2" ? .indonesian : .en)
                    UserDefaults.standard.set(startModel.retrieved, forKey: LDUserDefaultKey_CITY)
                    UserDefaults.standard.synchronize()
                    
                    self.window?.rootViewController = LDTabBarC()
                    self.window?.makeKeyAndVisible()
                    return
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
            }
            
            if let _window = self.window, let _we_vc = _window.rootViewController as? LDWecomeVC {
                _we_vc.retryBtn.isHidden = false
            }
            
            LDReqManager.requestList(url: .jsonUrl) { [weak self] result in
                switch result {
                case .success(let success):
                    getBaseUrl(urls: success)
                case .failure(_):
                    self?.setWelcomeVC(showRetry: true)
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        LDLocation.shared.config()
        LDUploadingInfoManager.location()
        LDUploadingInfoManager.deviceInfo()
        startApp()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    func setWelcomeVC(showRetry: Bool = false) {
        let welcome = LDWecomeVC()
        welcome.retryBtn.isHidden = !showRetry
        welcome.retryDelegate = self
        self.window?.rootViewController = welcome
        self.window?.makeKeyAndVisible()
    }
    
    func showAllFonts(){
        let familyNames = UIFont.familyNames
        
        var index:Int = 0
        
        for familyName in familyNames {
            
            let fontNames = UIFont.fontNames(forFamilyName: familyName as String)
            print("------- 字体家族 -------- \(familyName)")
            for fontName in fontNames
            {
                index += 1
                
                print("第 \(index) 个字体，字体font名称：\(fontName)")
            }
        }
    }
}

extension SceneDelegate: RetryRequestProtocol {
    func retryRequest() {
        startApp(isWecome: true)
    }
}

extension SceneDelegate {
    func FacebookChuShiHua(_ fbModel: LDStartCatalogModel) {
        Settings.shared.appID = fbModel.references
        Settings.shared.displayName = fbModel.disco
        Settings.shared.clientToken = fbModel.beckinsale
        Settings.shared.appURLSchemeSuffix = fbModel.afi
        Settings.shared.isAutoLogAppEventsEnabled = true
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
}

