//
//  LDDevice.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/15.
//

import Foundation
import UIKit
import Reachability
import CoreTelephony
import SystemConfiguration.CaptiveNetwork

class LDDevice {
    struct info {
        static var version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        static var name: String = UIDevice.current.name
        static var idfv: String {
            if let idfvStr = LDKeychain.readData(key: LDUserDefaultKey_IDFV) {
                return idfvStr
            } else {
                if let idfvStr = UIDevice.current.identifierForVendor?.uuidString {
                    LDKeychain.writeData(value: idfvStr, key: LDUserDefaultKey_IDFV)
                    return idfvStr
                }
            }
            return ""
        }
        static var systemVersion: String = UIDevice.current.systemVersion
        static var sID: String {
            if let sid = UserDefaults.standard.string(forKey: "LDUserDefaultKey_SID"), sid.count > 0 {
                return sid
            } else {
                return ""
            }
        }
        static var idfa: String {
            if let idfaStr = UserDefaults.standard.string(forKey: LDUserDefaultKey_IDFA) {
                return idfaStr
            }
            return ""
        }
        static var memory: [String: Any] {
            var canUseStorage = ""
            var totalStorage = ""
            var totalMemory = ""
            var canUseMemory = ""
            
            let url = URL(fileURLWithPath: NSTemporaryDirectory())
            if let resource = try? url.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey]), let result = resource.volumeAvailableCapacityForImportantUsage {
                canUseStorage = "\(result)"
            }
            
            if let attr = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()), let result = attr[.systemSize] as? Int64 {
                totalStorage = "\(result)"
            }
            
            var total: Int64 = 0
            var size = MemoryLayout<Int64>.size
            sysctlbyname("hw.memsize", &total, &size, nil, 0)
            totalMemory = "\(total)"
            
//            var memorySize = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
//            var vmStat = vm_statistics64()
//            var pageSize: vm_size_t = 0
//            let hostPort: mach_port_t = mach_host_self()
//            host_page_size(hostPort, &pageSize)
//            let status = withUnsafeMutablePointer(to: &vmStat) {
//                $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
//                    host_statistics64(hostPort, HOST_VM_INFO64, $0, &memorySize)
//                }
//            }
//            if status == KERN_SUCCESS {
//                let freeMemory = (
//                    UInt64(vmStat.free_count) +
//                    UInt64(vmStat.inactive_count) +
//                    UInt64(vmStat.external_page_count) +
//                    UInt64(vmStat.purgeable_count) -
//                    UInt64(vmStat.speculative_count)
//                ) * UInt64(pageSize)
//                
//                canUseMemory = "\(freeMemory)"
//            }
            
            var vmStats = vm_statistics_data_t()
            var infoCount = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
            
            let kernReturn = withUnsafeMutablePointer(to: &vmStats) {
                $0.withMemoryRebound(to: integer_t.self, capacity: Int(infoCount)) {
                    host_statistics(mach_host_self(), HOST_VM_INFO, $0, &infoCount)
                }
            }
            
            if kernReturn == KERN_SUCCESS {
                let availableMemorySize = (vm_page_size * UInt(vmStats.free_count + vmStats.inactive_count))
                canUseMemory = "\(availableMemorySize)"
            }
            
            return ["somewhat": canUseStorage,
                    "thought": totalStorage,
                    "enjoyable": totalMemory,
                    "despite": canUseMemory]
        }
        
        static var battery: [String: Any] {
            var residue: Int = 0
            var isRecharge: Int = 0
            
            UIDevice.current.isBatteryMonitoringEnabled = true
            
            residue = Int(UIDevice.current.batteryLevel * 100)
            
            let state = UIDevice.current.batteryState
            isRecharge = (state == .charging || state == .full) ? 1 : 0
            
            return ["salon": residue,
                    "hehir":isRecharge]
        }
        
        static var systemInfo: [String: Any] {
        
            return ["depth": systemVersion,
                    "vigour": UIDevice.current.model,
                    "wit": DeviceModel.identifier]
        }
        
        static var timeZone: [String: Any] {
            
            var networkType = ""
            let reach = try? Reachability()
            switch reach?.connection {
            case .wifi:
                networkType = "WiFi"
            case .cellular:
                let info = CTTelephonyNetworkInfo()
                if let tech = info.serviceCurrentRadioAccessTechnology?.first?.value {
                    if #available(iOS 14.1, *) {
                        switch tech {
                        case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
                            networkType = "2G"
                        case CTRadioAccessTechnologyWCDMA, CTRadioAccessTechnologyHSDPA, CTRadioAccessTechnologyHSUPA, CTRadioAccessTechnologyCDMAEVDORev0, CTRadioAccessTechnologyCDMAEVDORevA, CTRadioAccessTechnologyCDMAEVDORevB,CTRadioAccessTechnologyeHRPD:
                            networkType = "3G"
                        case CTRadioAccessTechnologyLTE:
                            networkType = "4G"
                        case CTRadioAccessTechnologyNRNSA, CTRadioAccessTechnologyNR:
                            networkType = "5G"
                        default:
                            networkType = "OTHER"
                        }
                    }
                }
                networkType = ""
            case .unavailable:
                networkType = "NONE"
            default:
                networkType = ""
            }
            
            var addressIP: String = ""
            var ifaddr: UnsafeMutablePointer<ifaddrs>?
            
            if getifaddrs(&ifaddr) == 0 {
                var pointer = ifaddr
                while pointer != nil {
                    guard let interface = pointer?.pointee else { continue }
                    let addrFamily = interface.ifa_addr.pointee.sa_family
                    
                    if addrFamily == UInt8(AF_INET) {
                        let name = String(cString: interface.ifa_name)
                        
                        if name == "en0" || name == "pdp_ip0" {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                        &hostname, socklen_t(hostname.count),
                                        nil, socklen_t(0), NI_NUMERICHOST)
                            addressIP = String(cString: hostname)
                            break
                        }
                    }
                    pointer = pointer?.pointee.ifa_next
                }
                freeifaddrs(ifaddr)
            }
            
            return ["bear": TimeZone.current.identifier,
                    "little": idfv,
                    "charm": addressIP,
                    "spare": networkType,
                    "amounts": idfa,
            ]
        }
        
        static var wifiInfo: [String: Any] {
            var name: String = ""
            var mac: String = ""
            if let cfas: NSArray = CNCopySupportedInterfaces() {
                for cfa in cfas {
                    if let dict = CFBridgingRetain(CNCopyCurrentNetworkInfo(cfa as! CFString)) {
                        let dic = dict as! NSDictionary
                        if let ssid = dic["SSID"] as? String, let bssid = dic["BSSID"] as? String {
                            name = ssid
                            mac = bssid
                        }
                    }
                }
            }
            return ["pleaser": ["crowd": mac,
                                "calling": mac,
                                "scorer": name,
                                "tenderness": name,]]
        }
        
        static var vpnInfo: [String: Any] {
            return ["posed": NSNumber(value: Device.isSimulator).intValue, "mop": NSNumber(value: JailbreakDetector.isJailbroken).intValue]
        }
        
        static var params: [String: Any] {
            return ["superficial": memory,
                    "stated": battery,
                    "andrew": systemInfo,
                    "too": timeZone,
                    "bags": wifiInfo,
                    "intermediate": vpnInfo
            ]
        }
    }
    
    static func isVPNConnected() -> Bool {
        guard let dict = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let keys = (dict["__SCOPED__"] as? [String: Any])?.keys else {
            return false
        }

        return keys.contains { key in
            key.contains("utun") ||
            key.contains("ppp") ||
            key.contains("ipsec") ||
            key.contains("tun")
        }
    }
    
    static func proxyInfo() -> (enabled: Bool, host: String?, port: Int?) {
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return (false, nil, nil)
        }

        if let httpEnable = settings["HTTPEnable"] as? Int, httpEnable == 1 {
            let host = settings["HTTPProxy"] as? String
            let port = settings["HTTPPort"] as? Int
            return (true, host, port)
        }

        if let httpsEnable = settings["HTTPSEnable"] as? Int, httpsEnable == 1 {
            let host = settings["HTTPSProxy"] as? String
            let port = settings["HTTPSPort"] as? Int
            return (true, host, port)
        }

        if let socksEnable = settings["SOCKSEnable"] as? Int, socksEnable == 1 {
            let host = settings["SOCKSProxy"] as? String
            let port = settings["SOCKSPort"] as? Int
            return (true, host, port)
        }

        return (false, nil, nil)
    }
}

class LDKeychain {
    static func writeData(value: String, key: String) {
        if let dataFrom = value.data(using: .utf8) {
            
            removeData(key)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: dataFrom
            ]
            
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    static func readData(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            if let retrievedData = dataTypeRef as? Data {
                return String(data: retrievedData, encoding: .utf8)
            }
        }
        
        return nil
    }
    
    static func removeData(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

enum Device {
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}

enum JailbreakDetector {

    static var isJailbroken: Bool {
        // 模拟器直接返回 false
        #if targetEnvironment(simulator)
        return false
        #endif

        return checkSuspiciousFiles()
            || canWriteOutsideSandbox()
            || canOpenCydiaURL()
    }

    // 1️⃣ 越狱常见文件
    private static func checkSuspiciousFiles() -> Bool {
        let paths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/"
        ]
        return paths.contains { FileManager.default.fileExists(atPath: $0) }
    }

    // 2️⃣ 尝试写沙盒外
    private static func canWriteOutsideSandbox() -> Bool {
        let testPath = "/private/jb_test.txt"
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testPath)
            return true
        } catch {
            return false
        }
    }

    // 3️⃣ 是否能打开 cydia
    private static func canOpenCydiaURL() -> Bool {
        guard let url = URL(string: "cydia://package/com.example.package") else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}

extension UIDevice {
    
    /// 判断是否为 Pad
    /// - Returns: bool
    static func isIpad() -> Bool {
        let pacerName = pacerName
        if pacerName.contains("iPad") {
            return true
        }
        return false
    }
    
    /// 设备的名字
    static var tabascoIdentifier: String {
        var forwardingInfo = utsname()
        uname(&forwardingInfo)
        let deferMirror = Mirror(reflecting: forwardingInfo.machine)
        let identifier = deferMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 设备的名字
    static var pacerName: String {
        let identifier = tabascoIdentifier
        func xm_mapToDevice(identifier: String) -> String {
            //MARK: os(iOS)
            #if os(iOS)
            switch identifier {
            case "iPod1,1":
                return "iPod touch"
            case "iPod2,1":
                return "iPod touch (2nd generation)"
            case "iPod3,1":
                return "iPod touch (3rd generation)"
            case "iPod4,1":
                return "iPod touch (4th generation)"
            case "iPod5,1":
                return "iPod touch (5th generation)"
            case "iPod7,1":
                return "iPod touch (6th generation)"
            case "iPod9,1":
                return "iPod touch (7th generation)"
            case "iPhone1,1":
                return "iPhone"
            case "iPhone1,2":
                return "iPhone 3G"
            case "iPhone2,1":
                return "iPhone 3GS"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":
                return "iPhone 4"
            case "iPhone4,1":
                return "iPhone 4S"
            case "iPhone5,1", "iPhone5,2":
                return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":
                return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":
                return "iPhone 5s"
            case "iPhone7,2":
                return "iPhone 6"
            case "iPhone7,1":
                return "iPhone 6 Plus"
            case "iPhone8,1":
                return "iPhone 6s"
            case "iPhone8,2":
                return "iPhone 6s Plus"
            case "iPhone8,4":
                return "iPhone SE (2nd generation)"
            case "iPhone9,1", "iPhone9,3":
                return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":
                return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":
                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":
                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":
                return "iPhone X"
            case "iPhone11,2":
                return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":
                return "iPhone XS Max"
            case "iPhone11,8":
                return "iPhone XR"
            case "iPhone12,1":
                return "iPhone 11"
            case "iPhone12,3":
                return "iPhone 11 Pro"
            case "iPhone12,5":
                return "iPhone 11 Pro Max"
            case "iPhone12,8":
                return "iPhone SE"
            case "iPhone13,1":
                return "iPhone 12 mini"
            case "iPhone13,2":
                return "iPhone 12"
            case "iPhone13,3":
                return "iPhone 12 Pro"
            case "iPhone13,4":
                return "iPhone 12 Pro Max"
            case "iPhone14,2":
                return "iPhone 13 Pro"
            case "iPhone14,3":
                return "iPhone 13 Pro Max"
            case "iPhone14,4":
                return "iPhone 13 mini"
            case "iPhone14,5":
                return "iPhone 13"
            case "iPhone14,6":
                return "iPhone SE (3rd generation)"
            case "iPhone14,7":
                return "iPhone 14"
            case "iPhone14,8":
                return "iPhone 14 Plus"
            case "iPhone15,2":
                return "iPhone 14 Pro"
            case "iPhone15,3":
                return "iPhone 14 Pro Max"
            case "iPhone15,4":
                return "iPhone 15"
            case "iPhone15,5":
                return "iPhone 15 Plus"
            case "iPhone16,1":
                return "iPhone 15 Pro"
            case "iPhone16,2":
                return "iPhone 15 Pro Max"
            case "iPad1,1":
                return "iPad"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
                return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":
                return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":
                return "iPad (4th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":
                return "iPad Air"
            case "iPad5,3", "iPad5,4":
                return "iPad Air 2"
            case "iPad6,11", "iPad6,12":
                return "iPad 5"
            case "iPad7,5", "iPad7,6":
                return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":
                return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":
                return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":
                return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":
                return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":
                return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":
                return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":
                return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":
                return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":
                return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":
                return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":
                return "Apple TV"
            case "AppleTV6,2":
                return "Apple TV 4K"
            case "AudioAccessory1,1":
                return "HomePod"
            case "i386", "x86_64":
                return "Simulator \(xm_mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:
                return identifier
            }
            //MARK: os(tvOS)
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3":
                return "Apple TV 4"
            case "AppleTV6,2":
                return "Apple TV 4K"
            case "i386", "x86_64":
                return "Simulator \(xm_mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default:
                return identifier
            }
            #endif
        }
        return xm_mapToDevice(identifier: identifier)
    }
}

struct DeviceModel {

    static var identifier: String {
        #if targetEnvironment(simulator)
        return ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "Simulator"
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }
        #endif
    }
}
