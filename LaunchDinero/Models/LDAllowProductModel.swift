//
//  LDAllowProductModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/19.
//

import Foundation

struct LDAllowProductModel: Codable {
    /// result
    var domestic: Int = 0
    /// terms
    var terms: [String] = []
    /// term_type
    var dallas: Int = 0
    /// loan_mode
    var loan_mode: Int = 0
    /// msg
    var sound: String = ""
    /// url
    var infinity: String = ""
    var retrieved: Int = 0
    var listed: Int = 0
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.domestic = try container.decodeIfPresent(Int.self, forKey: .domestic) ?? 0
        self.terms = try container.decodeIfPresent([String].self, forKey: .terms) ?? []
        self.dallas = try container.decodeIfPresent(Int.self, forKey: .dallas) ?? 0
        self.loan_mode = try container.decodeIfPresent(Int.self, forKey: .loan_mode) ?? 0
        self.sound = try container.decodeIfPresent(String.self, forKey: .sound) ?? ""
        self.infinity = try container.decodeIfPresent(String.self, forKey: .infinity) ?? ""
        self.retrieved = try container.decodeIfPresent(Int.self, forKey: .retrieved) ?? 0
        self.listed = try container.decodeIfPresent(Int.self, forKey: .listed) ?? 0
    }
}
