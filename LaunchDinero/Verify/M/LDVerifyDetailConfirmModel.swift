//
//  LDVerifyDetailConfirmModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import Foundation

struct LDVerifyDetailConfirmModel: Codable {
    /// isShowConfirm
    var social: Int = 0
    /// determines
    var determines: [LDVerifyDetailConfirmItemModel] = []
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.social = try container.decode(Int.self, forKey: .social)
        self.determines = try container.decode([LDVerifyDetailConfirmItemModel].self, forKey: .determines)
    }
}

struct LDVerifyDetailConfirmItemModel: Codable {
    var pmatrix: String = ""
    var begin: String = ""
    var numbers: String = ""
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pmatrix = try container.decode(String.self, forKey: .pmatrix)
        self.begin = try container.decode(String.self, forKey: .begin)
        self.numbers = try container.decode(String.self, forKey: .numbers)
    }
}
