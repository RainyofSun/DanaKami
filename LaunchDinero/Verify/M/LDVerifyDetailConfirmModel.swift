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
        if let _soics = try container.decodeIfPresent(Int.self, forKey: .social) {
            self.social = _soics
        }
        
        if let _determis = try container.decodeIfPresent([LDVerifyDetailConfirmItemModel].self, forKey: .determines) {
            self.determines = _determis
        }
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
