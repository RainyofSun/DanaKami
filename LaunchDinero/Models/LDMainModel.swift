//
//  LDMainModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/19.
//

import Foundation

struct LDMainModel: Codable {
    /// icon
    var centuries: LDMainCenturiesModel = LDMainCenturiesModel()
    /// isRepay
    var isRepay: Int = 0
    /// scrollMsg
    var scrollMsg: [String] = []
    /// isReyNoticeMsg
    var isReyNoticeMsg: String = ""
    /// realStatus
    var realStatus: Int = 0
    /// list
    var mathematicians: [LDMainMathematiciansModel] = []
    /// customer
    var customer: String = ""
    /// privacy
    var archived: String = ""
    /// festival
    var festival: LDMainFestivalModel = LDMainFestivalModel()
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.centuries = try container.decodeIfPresent(LDMainCenturiesModel.self, forKey: .centuries) ?? LDMainCenturiesModel()
        self.festival = try container.decodeIfPresent(LDMainFestivalModel.self, forKey: .festival) ?? LDMainFestivalModel()
        self.isRepay = try container.decodeIfPresent(Int.self, forKey: .isRepay) ?? 0
        self.scrollMsg = try container.decodeIfPresent([String].self, forKey: .scrollMsg) ?? []
        self.isReyNoticeMsg = try container.decodeIfPresent(String.self, forKey: .isReyNoticeMsg) ?? ""
        self.realStatus = try container.decodeIfPresent(Int.self, forKey: .realStatus) ?? 0
        self.mathematicians = try container.decodeIfPresent([LDMainMathematiciansModel].self, forKey: .mathematicians) ?? []
        self.customer = try container.decodeIfPresent(String.self, forKey: .customer) ?? ""
        self.archived = try container.decodeIfPresent(String.self, forKey: .archived) ?? ""
    }
}

struct LDMainCenturiesModel: Codable {
    /// iconUrl
    var fishermen: String = ""
    /// linkUrl
    var farmers: String = ""
    /// feedbackUrl
    var feedbackUrl: String = ""
    /// aboutUrl
    var aboutUrl: String = ""
}

struct LDMainFestivalModel: Codable {
    /// rainmaker
    var rainmaker: String = ""
    /// international
    var international: String = ""
}

struct LDMainMathematiciansModel: Codable {
    /// type
    var listeder: String = ""
    /// item
    var ramanujan: [LDMainrRamanujanModel] = []
}

struct LDMainrRamanujanModel: Codable {
    /// id
    var flag: Int = 0
    /// productName
    var portal: String = ""
    /// productLogo
    var writers: String = ""
    /// buttonText
    var turkish: String = ""
    /// amountRange
    var telly: String = ""
    /// amountRangeDes
    var southeastern: String = ""
    /// termInfo
    var female: String = ""
    /// termInfo1
    var termInfo1: String = ""
    /// termInfo2
    var termInfo2: String = ""
    /// termInfoDes
    var leading: String = ""
    /// loanRate
    var actors: String = ""
    /// loanRateDes
    var satellite: String = ""
    /// termInfoImg
    var russian: String = ""
    /// loanRateImg
    var promotion: String = ""
    /// yxTag
    var yxTag: [String] = []
    
    /// jump url
    var infinity: String = ""
    /// image url
    var knew: String = ""
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flag = try container.decodeIfPresent(Int.self, forKey: .flag) ?? 0
        self.portal = try container.decodeIfPresent(String.self, forKey: .portal) ?? ""
        self.writers = try container.decodeIfPresent(String.self, forKey: .writers) ?? ""
        self.turkish = try container.decodeIfPresent(String.self, forKey: .turkish) ?? ""
        self.telly = try container.decodeIfPresent(String.self, forKey: .telly) ?? ""
        self.southeastern = try container.decodeIfPresent(String.self, forKey: .southeastern) ?? ""
        self.female = try container.decodeIfPresent(String.self, forKey: .female) ?? ""
        self.termInfo1 = try container.decodeIfPresent(String.self, forKey: .termInfo1) ?? ""
        self.termInfo2 = try container.decodeIfPresent(String.self, forKey: .termInfo2) ?? ""
        self.leading = try container.decodeIfPresent(String.self, forKey: .leading) ?? ""
        self.actors = try container.decodeIfPresent(String.self, forKey: .actors) ?? ""
        self.satellite = try container.decodeIfPresent(String.self, forKey: .satellite) ?? ""
        self.russian = try container.decodeIfPresent(String.self, forKey: .russian) ?? ""
        self.promotion = try container.decodeIfPresent(String.self, forKey: .promotion) ?? ""
        self.yxTag = try container.decodeIfPresent([String].self, forKey: .yxTag) ?? []
        self.infinity = try container.decodeIfPresent(String.self, forKey: .infinity) ?? ""
        self.knew = try container.decodeIfPresent(String.self, forKey: .knew) ?? ""
    }
}
