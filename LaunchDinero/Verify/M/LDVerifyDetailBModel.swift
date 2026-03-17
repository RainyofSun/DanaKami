//
//  LDVerifyDetailBModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import Foundation

struct LDVerifyDetailBModel: Codable {
    /// id_front
    var actress: LDVerifyDetailBPhotoModel = LDVerifyDetailBPhotoModel()
    /// liveness
    var subtext: LDVerifyDetailBPhotoModel = LDVerifyDetailBPhotoModel()
    /// id_front_msg
    var id_front_msg: String = ""
    /// livenessType
    var accolades: Int = 0
    /// face_msg
    var face_msg: String = ""
}

struct LDVerifyDetailBPhotoModel: Codable {
    /// status
    var society: Int = 0
    /// url
    var infinity: String = ""
    /// info
    var ref: LDVerifyDetailBPhotoInfoModel = LDVerifyDetailBPhotoInfoModel()
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.society = try container.decodeIfPresent(Int.self, forKey: .society) ?? 0
        self.infinity = try container.decodeIfPresent(String.self, forKey: .infinity) ?? ""
        self.ref = try container.decodeIfPresent(LDVerifyDetailBPhotoInfoModel.self, forKey: .ref) ?? LDVerifyDetailBPhotoInfoModel()
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
