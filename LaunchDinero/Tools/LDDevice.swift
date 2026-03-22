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
            
            var info = utsname()
            uname(&info)
            let mirror = Mirror(reflecting: info.machine)
            let name = mirror.children.compactMap { item in
                guard let v = item.value as? Int8, v != 0 else {
                    return nil
                }
                return String(UnicodeScalar(UInt8(v)))
            }.joined()
            
            return ["depth": systemVersion,
                    "vigour": UIDevice.current.model,
                    "wit": name]
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
                    "amounts": idfa]
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
        
        static var params: [String: Any] {
            return ["superficial": memory,
                    "stated": battery,
                    "andrew": systemInfo,
                    "too": timeZone,
                    "bags": wifiInfo]
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
