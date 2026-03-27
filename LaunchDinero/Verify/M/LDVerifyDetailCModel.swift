//
//  LDVerifyDetailCModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/23.
//

import Foundation

struct LDVerifyDetailCModel: Codable {
    /// emergent
    var catholics: [LDVerifyDetailCItemModel] = []
}

struct LDVerifyDetailCItemModel: Codable {
    /// relation
    var irish: String = ""
    /// name
    var scorer: String = ""
    /// mobile
    var backdrop: String = ""
    /// title
    var rainmaker: String = ""
    /// relation_text
    var important: String = ""
    /// relation_reminder
    var tensions: String = ""
    /// mobile_text
    var protestant: String = ""
    /// mobile_reminder
    var catholic: String = ""
    /// note
    var lyrics: [LDVerifyDetailCLyricsModel] = []
}

struct LDVerifyDetailCLyricsModel: Codable {
    /// name
    var scorer: String = ""
    /// type
    var listeder: Int = 0
    
    init(){}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.scorer = try container.decode(String.self, forKey: .scorer)
        if let liste = try? container.decodeIfPresent(String.self, forKey: .listeder) {
            self.listeder = Int(liste) ?? 0
        } else if let listederInt = try? container.decodeIfPresent(Int.self, forKey: .listeder) {
            self.listeder = listederInt
        }
    }
}
