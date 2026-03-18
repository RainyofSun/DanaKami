//
//  LDVerifyModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/20.
//

import Foundation

struct LDVerifyModel: Codable {
    /// result
    var domestic: Int = 0
    /// productDetail
    var reel: LDVerifyReelModel = LDVerifyReelModel()
    /// verify
    var promising: [LDVerifyPromisingModel] = []
    /// nextStep
    var golden: LDVerifyGoldenModel = LDVerifyGoldenModel()
    /// agreement
    var festival: LDVerifyFestivalModel = LDVerifyFestivalModel()
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.domestic = try container.decodeIfPresent(Int.self, forKey: .domestic) ?? 0
        self.reel = try container.decodeIfPresent(LDVerifyReelModel.self, forKey: .reel) ?? LDVerifyReelModel()
        self.promising = try container.decodeIfPresent([LDVerifyPromisingModel].self, forKey: .promising) ?? []
        self.golden = try container.decodeIfPresent(LDVerifyGoldenModel.self, forKey: .golden) ?? LDVerifyGoldenModel()
        self.festival = try container.decodeIfPresent(LDVerifyFestivalModel.self, forKey: .festival) ?? LDVerifyFestivalModel()
    }
}

struct LDVerifyReelModel: Codable {
    /// amountArr
    var globe: [String] = []
    /// amount
    var newcomer: String = ""
    /// termArr
    var circle: [String] = []
    /// amountDesc
    var florida: String = ""
    /// termDesc
    var european: String = ""
    /// id
    var flag: String = ""
    /// productName
    var portal: String = ""
    /// productLogo
    var writers: String = ""
    /// orderNo
    var empire: String = ""
    /// orderId
    var pictures: Int = 0
    /// columnText
    var directorial: LDVerifyDirectorialModel = LDVerifyDirectorialModel()
    /// buttonText
    var turkish: String = ""
    /// buttonUrl
    var worth: String = ""
    /// term
    var fort: Int = 0
    /// term_type
    var dallas: Int = 0
    /// url
    var infinity: String = ""
    /// hotline
    var breakthrough: LDVerifyBreakthroughModel = LDVerifyBreakthroughModel()
    /// complaintUrl
    var chlotrudis: String = ""
}

struct LDVerifyDirectorialModel: Codable {
    /// tag1
    var america: LDVerifyDirectorialItemModel = LDVerifyDirectorialItemModel()
    /// tag2
    var directors: LDVerifyDirectorialItemModel = LDVerifyDirectorialItemModel()
}

struct LDVerifyDirectorialItemModel: Codable {
    /// title
    var rainmaker: String = ""
    /// text
    var guild: String = ""
}

struct LDVerifyBreakthroughModel: Codable {
    /// value
    var choice: String = ""
}

struct LDVerifyPromisingModel: Codable {
    /// title
    var rainmaker: String = ""
    /// subtitle
    var association: String = ""
    /// type
    var listeder: Int = 0
    /// url
    var infinity: String = ""
    /// status
    var society: Int = 0
    /// statusName
    var tv: String = ""
    /// taskType
    var bmi: String = ""
    /// canClick
    var video: Int = 0
    /// optional
    var blockbuster: Int = 0
    /// ifMust
    var achievement: Int = 0
    /// canClickMessage
    var single: String = ""
    /// log
    var outstanding: String = ""
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rainmaker = try container.decodeIfPresent(String.self, forKey: .rainmaker) ?? ""
        self.association = try container.decodeIfPresent(String.self, forKey: .association) ?? ""
        self.listeder = try container.decodeIfPresent(Int.self, forKey: .listeder) ?? 0
        self.infinity = try container.decodeIfPresent(String.self, forKey: .infinity) ?? ""
        self.society = try container.decodeIfPresent(Int.self, forKey: .society) ?? 0
        self.tv = try container.decodeIfPresent(String.self, forKey: .tv) ?? ""
        self.bmi = try container.decodeIfPresent(String.self, forKey: .bmi) ?? ""
        self.video = try container.decodeIfPresent(Int.self, forKey: .video) ?? 0
        self.blockbuster = try container.decodeIfPresent(Int.self, forKey: .blockbuster) ?? 0
        self.achievement = try container.decodeIfPresent(Int.self, forKey: .achievement) ?? 0
        self.single = try container.decodeIfPresent(String.self, forKey: .single) ?? ""
        self.outstanding = try container.decodeIfPresent(String.self, forKey: .outstanding) ?? ""
    }
}

struct LDVerifyGoldenModel: Codable {
    /// taskType
    var bmi: String = ""
    /// url
    var infinity: String = ""
    /// type
    var listeder: Int = 0
    /// title
    var rainmaker: String = ""
}

struct LDVerifyFestivalModel: Codable {
    /// title
    var rainmaker: String = ""
    /// urlLink
    var international: String = ""
}
