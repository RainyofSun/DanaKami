//
//  LDVerifyDetailAModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/22.
//

import Foundation

struct LDVerifyDetailAModel: Codable {
    /// items
    var feature: [LDVerifyDetailAItemModel] = []
}

struct LDVerifyDetailAItemModel: Codable {
    /// id
    var flag: Int = 0
    /// title
    var rainmaker: String = ""
    /// subtitle
    var association: String = ""
    /// code
    var numbers: String = ""
    /// cate
    var editors: String = ""
    /// note
    var lyrics: [LDVerifyDetailCLyricsModel] = []
    /// optional
    var blockbuster: Int = 0
    /// status
    var society: Int = 0
    /// statusName
    var tv: String = ""
    /// enable
    var dramatic: Bool = false
    /// value
    var choice: String = ""
    /// dateSelect
    var editing: Int = 0
    /// listeder
    var listeder: String = ""
    
    var cinema: Int = 0
    
    var isShow: Bool = true
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flag = try container.decodeIfPresent(Int.self, forKey: .flag) ?? 0
        self.rainmaker = try container.decodeIfPresent(String.self, forKey: .rainmaker) ?? ""
        self.association = try container.decodeIfPresent(String.self, forKey: .association) ?? ""
        self.numbers = try container.decodeIfPresent(String.self, forKey: .numbers) ?? ""
        self.editors = try container.decodeIfPresent(String.self, forKey: .editors) ?? ""
        self.lyrics = try container.decodeIfPresent([LDVerifyDetailCLyricsModel].self, forKey: .lyrics) ?? []
        self.blockbuster = try container.decodeIfPresent(Int.self, forKey: .blockbuster) ?? 0
        self.society = try container.decodeIfPresent(Int.self, forKey: .society) ?? 0
        self.tv = try container.decodeIfPresent(String.self, forKey: .tv) ?? ""
        self.dramatic = try container.decodeIfPresent(Bool.self, forKey: .dramatic) ?? false
        if let choiceStr = try? container.decodeIfPresent(String.self, forKey: .choice) {
            self.choice = choiceStr
        } else if let choiceInt = try? container.decodeIfPresent(Int.self, forKey: .choice) {
            self.choice = "\(choiceInt)"
        }
        
        if let liste = try? container.decodeIfPresent(String.self, forKey: .listeder) {
            self.listeder = liste
        } else if let listederInt = try? container.decodeIfPresent(Int.self, forKey: .listeder) {
            self.listeder = "\(listederInt)"
        }
        
        self.editing = try container.decodeIfPresent(Int.self, forKey: .editing) ?? 0
        self.cinema = try container.decodeIfPresent(Int.self, forKey: .cinema) ?? 0
        self.isShow = try container.decodeIfPresent(Bool.self, forKey: .isShow) ?? true
    }
}
