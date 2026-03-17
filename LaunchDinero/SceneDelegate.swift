//
//  SceneDelegate.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
//        startApp()
        self.window?.rootViewController = LDWecomeVC()
        self.window?.makeKeyAndVisible()
    }
    
    func startApp(isWecome: Bool = false) {
        
        if isWecome, let ws = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            self.window = ws.windows.first
        }
        self.window?.LDShowActivity()
        LDReqManager.request(url: LDReqURL.firstUrl, modelType: LDStartModel.self) { result in
            self.window?.LDHideActivity()
            switch result {
            case .success(let success):
                if let m = success.financial {
                    startModel = m
                    LDLocalLanguage.shared.configLanguage(type: startModel.retrieved == 2 ? .es : .en)
                    UserDefaults.standard.set(startModel.retrieved, forKey: LDUserDefaultKey_CITY)
                    self.window?.rootViewController = LDTabBarC()
                    self.window?.makeKeyAndVisible()
                    return
                }
            case .failure(_):
                break
            }
            LDReqManager.requestList(url: .jsonUrl) { result in
                switch result {
                case .success(let success):
                    getBaseUrl(urls: success)
                case .failure(_):
                    self.window?.rootViewController = LDWecomeVC()
                    self.window?.makeKeyAndVisible()
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


}

