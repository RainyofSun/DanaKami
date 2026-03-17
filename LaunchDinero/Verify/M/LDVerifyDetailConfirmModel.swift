//
//  LDVerifyDetailConfirmModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import Foundation

struct LDVerifyDetailConfirmModel: Codable {
    /// name
    var commented: String = ""
    /// ID
    var lipset: String = ""
    /// gender
    var david: String = ""
    /// birthday
    var nominee: String = ""
    var infinity: String = ""
    var similarly: String = ""
    var mobility: String = ""
    /// isShowConfirm
    var social: Int = 0
    var society: Bool = false
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.commented = try container.decodeIfPresent(String.self, forKey: .commented) ?? ""
        self.lipset = try container.decodeIfPresent(String.self, forKey: .lipset) ?? ""
        self.david = try container.decodeIfPresent(String.self, forKey: .david) ?? ""
        self.nominee = try container.decodeIfPresent(String.self, forKey: .nominee) ?? ""
        self.infinity = try container.decodeIfPresent(String.self, forKey: .infinity) ?? ""
        self.similarly = try container.decodeIfPresent(String.self, forKey: .similarly) ?? ""
        self.mobility = try container.decodeIfPresent(String.self, forKey: .mobility) ?? ""
        self.social = try container.decodeIfPresent(Int.self, forKey: .social) ?? 0
        self.society = try container.decodeIfPresent(Bool.self, forKey: .society) ?? false
    }
}
