//
//  LDStartModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/15.
//

import Foundation

struct LDStartModel: Codable {
    /// 1=India，2=Mexico
    var retrieved: Int = 1
    /// agreement
    var archived: String = ""
    /// Facebook
    var catalog: LDStartCatalogModel = LDStartCatalogModel()
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.retrieved = try container.decodeIfPresent(Int.self, forKey: .retrieved) ?? 1
        self.archived = try container.decodeIfPresent(String.self, forKey: .archived) ?? ""
        self.catalog = try container.decodeIfPresent(LDStartCatalogModel.self, forKey: .catalog) ?? LDStartCatalogModel()
    }
}

struct LDStartCatalogModel: Codable {
    /// CFBundleURLScheme
    var afi: String = ""
    /// FacebookAppID
    var references: String = ""
    /// FacebookDisplayName
    var disco: String = ""
    /// FacebookClientToke
    var beckinsale: String = ""
}

var startModel: LDStartModel = LDStartModel()
