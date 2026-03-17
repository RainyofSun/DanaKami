//
//  LDPermissionManager.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import Foundation
import AVFoundation
import UIKit
import Contacts
import AppTrackingTransparency
import AdSupport
import CoreLocation

class LDPermissionManager {
    static func requestPermission(currentVC: UIViewController, text: String = "Please go to 'Settings' grant permissions") {
        let alertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { _ in
            if let settings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settings)
            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(action1)
        alertController.addAction(action2)
        currentVC.present(alertController, animated: true)
    }
    
    static func camera(allow: @escaping (Bool) -> Void) {
        let s = AVCaptureDevice.authorizationStatus(for: .video)
        switch s {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                allow(granted)
            }
        case .restricted:
            allow(false)
        case .denied:
            allow(false)
        case .authorized:
            allow(true)
        @unknown default:
            allow(false)
        }
    }
    
    static func contacts(allow: @escaping (Bool) -> Void) {
        let s = CNContactStore.authorizationStatus(for: .contacts)
        switch s {
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    allow(granted)
                }
            }
        case .restricted:
            allow(false)
        case .denied:
            allow(false)
        case .authorized:
            allow(true)
        case .limited:
            allow(true)
        @unknown default:
            allow(false)
        }
    }
    
    static func tracking() {
        let s = ATTrackingManager.trackingAuthorizationStatus
        switch s {
        case .notDetermined:
            DispatchQueue.main.async {
                ATTrackingManager.requestTrackingAuthorization { status in
                    if status == .authorized {
                        UserDefaults.standard.set(ASIdentifierManager.shared().advertisingIdentifier.uuidString, forKey: LDUserDefaultKey_IDFA)
                    }
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            break
        @unknown default:
            break
        }
    }
    
    static func location(allow: @escaping (Bool) -> Void) {
        let s = CLLocationManager().authorizationStatus
        switch s {
        case .notDetermined:
            allow(false)
        case .restricted:
            allow(false)
        case .denied:
            allow(false)
        case .authorizedAlways:
            allow(true)
        case .authorizedWhenInUse:
            allow(true)
        case .authorized:
            allow(true)
        @unknown default:
            allow(false)
        }
    }
}
