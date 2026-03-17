//
//  LDReqManager.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/15.
//

import Foundation
import Moya
import SwiftyJSON

//var LDUrl: String = "http://47.88.2.107:8266/nomination"
var LDUrl: String = "https://lcm.rupantar-investments.com/nomination"

enum LDReqURL {
    case firstUrl
    case jsonUrl
    case loginCodeUrl(params: [String: Any])
    case loginVoiceUrl(params: [String: Any])
    case loginUrl(params: [String: Any])
    case userInfoUrl
    case userOutUrl
    case userDeleteUrl
    case mainUrl
    case allowProductUrl(params: [String: Any])
    case verifyListUrl(params: [String: Any])
    case verifyDetailWJUrl(params: [String: Any])
    case verifyDetailSFZUrl(params: [String: Any])
    case verifyDetailGRXXUrl(params: [String: Any])
    case verifyDetailGZXXUrl(params: [String: Any])
    case verifyDetailLXRUrl(params: [String: Any])
    case verifyDetailBKUrl(params: [String: Any])
    case verifyCommitWJUrl(params: [String: Any])
    case verifyCommitSFZUrl(params: [String: Any], imgData: Data)
    case verifyCommitGRXXUrl(params: [String: Any])
    case verifyCommitGZXXUrl(params: [String: Any])
    case verifyCommitLXRUrl(params: [String: Any])
    case verifyCommitBKUrl(params: [String: Any])
    case verifySFZConfirmUrl(params: [String: Any])
    case playAnOrder(params: [String: Any])
    case allOrderUrl(params: [String: Any])
    case uploadingLocationUrl(params: [String: Any])
    case uploadingIdfvIdfaUrl(params: [String: Any])
    case uploadingBasePointUrl(params: [String: Any])
    case uploadingDeviceInfoUrl(params: [String: Any])
    case uploadingContactsUrl(params: [String: Any])
}

extension LDReqURL: TargetType {
    var baseURL: URL {
        switch self {
        case .jsonUrl:
            URL(string: "https://mx02-dc.oss-us-west-1.aliyuncs.com/launch-dinero/at.json")!
        default:
            URL(string: LDUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .firstUrl:
            return "/utman/movies"
        case .jsonUrl:
            return ""
        case .loginCodeUrl:
            return "/utman/mojo"
        case .loginVoiceUrl:
            return "/utman/numbers"
        case .loginUrl:
            return "/utman/information"
        case .userInfoUrl:
            return "/utman/flag"
        case .userOutUrl:
            return "/utman/financial"
        case .userDeleteUrl:
            return "/utman/female"
        case .mainUrl:
            return "/utman/catalog"
        case .allowProductUrl:
            return "/utman/afi"
        case .verifyListUrl:
            return "/utman/references"
        case .verifyDetailWJUrl:
            return "/utman/disco"
        case .verifyDetailSFZUrl:
            return "/utman/kate"
        case .verifyDetailGRXXUrl:
            return "/utman/county"
        case .verifyDetailGZXXUrl:
            return "/utman/centuries"
        case .verifyDetailLXRUrl:
            return "/utman/farmers"
        case .verifyDetailBKUrl:
            return "/utman/ramanujan"
        case .verifyCommitWJUrl:
            return "/utman/beckinsale"
        case .verifyCommitSFZUrl:
            return "/utman/tied"
        case .verifyCommitGRXXUrl:
            return "/utman/essex"
        case .verifyCommitGZXXUrl:
            return "/utman/fishermen"
        case .verifyCommitLXRUrl:
            return "/utman/mathematicians"
        case .verifyCommitBKUrl:
            return "/utman/infinity"
        case .verifySFZConfirmUrl:
            return "/utman/notes"
        case .playAnOrder:
            return "/utman/knew"
        case .allOrderUrl:
            return "/utman/icon"
        case .uploadingLocationUrl:
            return "/utman/writers"
        case .uploadingIdfvIdfaUrl:
            return "/utman/telly"
        case .uploadingBasePointUrl:
            return "/utman/portal"
        case .uploadingDeviceInfoUrl:
            return "/utman/turkish"
        case .uploadingContactsUrl:
            return "/utman/online"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .firstUrl,
                .jsonUrl,
                .userInfoUrl,
                .userOutUrl,
                .userDeleteUrl,
                .mainUrl:
            return .get
        case .loginCodeUrl,
                .loginVoiceUrl,
                .loginUrl,
                .allowProductUrl,
                .verifyListUrl,
                .verifyDetailWJUrl,
                .verifyDetailSFZUrl,
                .verifyDetailGRXXUrl,
                .verifyDetailGZXXUrl,
                .verifyDetailLXRUrl,
                .verifyDetailBKUrl,
                .verifyCommitWJUrl,
                .verifyCommitSFZUrl,
                .verifyCommitGRXXUrl,
                .verifyCommitGZXXUrl,
                .verifyCommitLXRUrl,
                .verifyCommitBKUrl,
                .verifySFZConfirmUrl,
                .playAnOrder,
                .allOrderUrl,
                .uploadingLocationUrl,
                .uploadingIdfvIdfaUrl,
                .uploadingBasePointUrl,
                .uploadingDeviceInfoUrl,
                .uploadingContactsUrl:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .firstUrl,
                .jsonUrl,
                .userInfoUrl,
                .userOutUrl,
                .userDeleteUrl,
                .mainUrl:
            return .requestParameters(parameters: LDReqManager.parameters, encoding: URLEncoding.default)
        case .loginCodeUrl(let dict),
                .loginVoiceUrl(let dict),
                .loginUrl(let dict),
                .allowProductUrl(let dict),
                .verifyListUrl(let dict),
                .verifyDetailWJUrl(let dict),
                .verifyDetailSFZUrl(let dict),
                .verifyDetailGRXXUrl(let dict),
                .verifyDetailGZXXUrl(let dict),
                .verifyDetailLXRUrl(let dict),
                .verifyDetailBKUrl(let dict),
                .verifyCommitWJUrl(let dict),
                .verifyCommitGRXXUrl(let dict),
                .verifyCommitGZXXUrl(let dict),
                .verifyCommitLXRUrl(let dict),
                .verifyCommitBKUrl(let dict),
                .verifySFZConfirmUrl(let dict),
                .playAnOrder(let dict),
                .allOrderUrl(let dict),
                .uploadingLocationUrl(let dict),
                .uploadingIdfvIdfaUrl(let dict),
                .uploadingBasePointUrl(let dict),
                .uploadingDeviceInfoUrl(let dict),
                .uploadingContactsUrl(let dict):
            var formData: [MultipartFormData] = []
            for (key, v) in dict {
                if let str = "\(v)".data(using: .utf8) {
                    let item = MultipartFormData(provider: .data(str), name: key)
                    formData.append(item)
                }
            }
            return .uploadCompositeMultipart(formData, urlParameters: LDReqManager.parameters)
        case .verifyCommitSFZUrl(let dict, let imgData):
            var formData: [MultipartFormData] = []
            for (key, v) in dict {
                if let str = "\(v)".data(using: .utf8) {
                    let item = MultipartFormData(provider: .data(str), name: key)
                    formData.append(item)
                }
            }
            formData.append(MultipartFormData(provider: .data(imgData), name: "ofWifes", fileName: "image.jpg", mimeType: "image/jpeg"))
            return .uploadCompositeMultipart(formData, urlParameters: LDReqManager.parameters)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .jsonUrl:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "multipart/form-data"]
        }
    }
    
    
}

class LDReqManager {
    class func request<T: Codable>(url: LDReqURL, modelType: T.Type, completion: @escaping (Result<LDDefaultModel<T>, Error>) -> Void) {
        let p = MoyaProvider<LDReqURL>()
        
        p.request(url) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    let response = LDDefaultModel<T>(from: json)
                    if response.numbers == -2 {
                        UserDefaults.standard.set(nil, forKey: LDUserDefaultKey_SID)
                    }
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    class func requestList(url: LDReqURL, completion: @escaping (Result<[String], Error>) -> Void) {
        let p = MoyaProvider<LDReqURL>()
        
        p.request(url) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSON(data: response.data)
                    if let list = json.rawValue as? [[String: Any]] {
                        let re = list.map { item in
                            if let str = item["lc"] as? String {
                                return str
                            } else {
                                return ""
                            }
                        }
                        completion(.success(re))
                    } else {
                        completion(.success([]))
                    }
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static var parameters: [String: Any] {
        var retrieved: String = ""
        if let str = UserDefaults.standard.value(forKey: LDUserDefaultKey_CITY) as? Int {
            retrieved = "\(str)"
        }
        return [
            "arc": LDDevice.info.version,
            "narrative": LDDevice.info.name,
            "predictable": LDDevice.info.idfv,
            "follows": LDDevice.info.systemVersion,
            "consensus": LDDevice.info.sID,
            "website": LDDevice.info.idfa,
            "retrieved": retrieved,
        ]
    }
}

struct LDDefaultModel<T: Codable> {
    /// code
    var numbers: Int = 0
    /// message
    var information: String = ""
    /// data
    var financial: T?
    
    init(from json: JSON) {
        self.numbers = json["numbers"].intValue
        self.information = json["information"].stringValue
        do {
            let dataJson = try json["financial"].rawData()
            self.financial = try JSONDecoder().decode(T.self, from: dataJson)
        } catch {
            self.financial = nil
        }
        
    }
}
