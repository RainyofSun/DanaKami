//
//  DeviceWifiManager.swift
//  LaunchDinero
//
//  Created by 一刻 on 2026/4/20.
//

import UIKit

import NetworkExtension
import CoreLocation

public class DeviceWifiManager: NSObject {
    
    // MARK: - 单例
    public static let shared = DeviceWifiManager()
    open var cacheWifiInfo: (ssid: String?, bssid: String?)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - 私有属性
    private let locationManager = CLLocationManager()
    private var completionHandler: ((_ ssid: String?, _ bssid: String?, _ error: Error?) -> Void)?
    
    // MARK: - 公共方法
    
    /// 获取当前连接的 Wi-Fi 信息
    /// - Parameter completion: 返回 SSID、BSSID 或错误
    public func getCurrentWiFiInfo(completion: @escaping (_ ssid: String?, _ bssid: String?, _ error: Error?) -> Void) {
        if let _info = self.cacheWifiInfo {
            self.completionHandler?(_info.ssid, _info.bssid, nil)
            return
        }
        
        self.completionHandler = completion
        checkLocationPermission()
    }
    
    // MARK: - 私有方法
    
    private func checkLocationPermission() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            // 首次请求权限
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            // 已授权，获取 Wi-Fi 信息
            fetchWiFiInfo()
        case .denied, .restricted:
            // 权限被拒绝
            completionHandler?(nil, nil, NSError(domain: "WiFiError",
                                                 code: 100,
                                                 userInfo: [NSLocalizedDescriptionKey: "定位权限被拒绝"]))
        @unknown default:
            completionHandler?(nil, nil, NSError(domain: "WiFiError",
                                                 code: -1,
                                                 userInfo: [NSLocalizedDescriptionKey: "未知错误"]))
        }
    }
    
    private func fetchWiFiInfo() {
        NEHotspotNetwork.fetchCurrent { [weak self] network in
            guard let self = self else { return }
            
            if let network = network {
                // 成功获取 SSID / BSSID
                self.cacheWifiInfo = (network.ssid, network.bssid)
                self.completionHandler?(network.ssid, network.bssid, nil)
            } else {
                // 未连接 Wi-Fi 或不可访问
                self.completionHandler?(nil, nil, NSError(domain: "WiFiError",
                                                          code: 200,
                                                          userInfo: [NSLocalizedDescriptionKey: "未连接 Wi-Fi 或无法获取信息"]))
            }
            
            // 使用完回调后释放
            self.completionHandler = nil
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension DeviceWifiManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 权限变化后再次尝试获取 Wi-Fi
        checkLocationPermission()
    }
}
