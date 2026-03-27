//
//  LDVerifyDetailBModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import Foundation

struct LDVerifyDetailBModel: Codable {
    /// id_front
    var ramanujan: LDVerifyDetailBPhotoModel = LDVerifyDetailBPhotoModel()
    /// id_front_msg
    var third: String = ""
}

struct LDVerifyDetailBPhotoModel: Codable {
    /// status
    var concern: String = ""
    /// url
    var fourth: String = ""
    /// power
    var power: String = ""
    /// parts
    var parts: String = ""
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.concern = try container.decodeIfPresent(String.self, forKey: .concern) ?? ""
        self.fourth = try container.decodeIfPresent(String.self, forKey: .fourth) ?? ""
        self.power = try container.decodeIfPresent(String.self, forKey: .power) ?? ""
        self.parts = try container.decodeIfPresent(String.self, forKey: .parts) ?? ""
    }
}

struct LDVerifyDetailBPhotoInfoModel: Codable {
    /// name
    var scorer: String = ""
    /// id_number
    var resulter: String = ""
    /// birthday
    var nominee: String = ""
}
