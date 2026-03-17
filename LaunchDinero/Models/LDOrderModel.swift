//
//  LDOrderModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/24.
//

import Foundation

struct LDOrderModel: Codable {
    /// list
    var mathematicians: [LDOrderItemModel] = []
    /// pages
    var odd: Int = 0
}

struct LDOrderItemModel: Codable {
    /// orderId
    var pictures: Int = 0
    /// productId
    var geography: Int = 0
    /// inside
    var filmmaking: Int = 0
    /// productName
    var portal: String = ""
    /// productLogo
    var writers: String = ""
    /// orderStatus
    var cultural: Int = 0
    /// date
    var religion: String = ""
    /// noticeText
    var role: String = ""
    /// buttonText
    var turkish: String = ""
    /// orderStatusDesc
    var examined: String = ""
    /// orderAmount
    var scholars: String = ""
    /// loanDetailUrl
    var academic: String = ""
    /// buttonUrl
    var worth: String = ""
    /// dateText
    var showcased: String = ""
    /// moneyText
    var quite: String = ""
    /// LoanAmountDesc
    var LoanAmountDesc: String = ""
    /// loanTime
    var beautifully: String = ""
    /// repayTime
    var variety: String = ""
    /// term
    var fort: String = ""
    /// amountDesc
    var florida: String = ""
    /// termDesc
    var european: String = ""
    /// amplyLink
    var amplyLink: String = ""
    /// listData
    var levy: [LDOrderLevyModel] = []
    /// agreement_txt
    var help: String = ""
    /// agreement_url
    var lapses: String = ""
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pictures = try container.decodeIfPresent(Int.self, forKey: .pictures) ?? 0
        self.geography = try container.decodeIfPresent(Int.self, forKey: .geography) ?? 0
        self.filmmaking = try container.decodeIfPresent(Int.self, forKey: .filmmaking) ?? 0
        self.portal = try container.decodeIfPresent(String.self, forKey: .portal) ?? ""
        self.writers = try container.decodeIfPresent(String.self, forKey: .writers) ?? ""
        self.cultural = try container.decodeIfPresent(Int.self, forKey: .cultural) ?? 0
        self.religion = try container.decodeIfPresent(String.self, forKey: .religion) ?? ""
        self.role = try container.decodeIfPresent(String.self, forKey: .role) ?? ""
        self.turkish = try container.decodeIfPresent(String.self, forKey: .turkish) ?? ""
        self.examined = try container.decodeIfPresent(String.self, forKey: .examined) ?? ""
        self.scholars = try container.decodeIfPresent(String.self, forKey: .scholars) ?? ""
        self.academic = try container.decodeIfPresent(String.self, forKey: .academic) ?? ""
        self.worth = try container.decodeIfPresent(String.self, forKey: .worth) ?? ""
        self.showcased = try container.decodeIfPresent(String.self, forKey: .showcased) ?? ""
        self.quite = try container.decodeIfPresent(String.self, forKey: .quite) ?? ""
        self.LoanAmountDesc = try container.decodeIfPresent(String.self, forKey: .LoanAmountDesc) ?? ""
        self.beautifully = try container.decodeIfPresent(String.self, forKey: .beautifully) ?? ""
        self.variety = try container.decodeIfPresent(String.self, forKey: .variety) ?? ""
        self.fort = try container.decodeIfPresent(String.self, forKey: .fort) ?? ""
        self.florida = try container.decodeIfPresent(String.self, forKey: .florida) ?? ""
        self.european = try container.decodeIfPresent(String.self, forKey: .european) ?? ""
        self.amplyLink = try container.decodeIfPresent(String.self, forKey: .amplyLink) ?? ""
        self.levy = try container.decodeIfPresent([LDOrderLevyModel].self, forKey: .levy) ?? []
        self.help = try container.decodeIfPresent(String.self, forKey: .help) ?? ""
        self.lapses = try container.decodeIfPresent(String.self, forKey: .lapses) ?? ""
    }
}

struct LDOrderLevyModel: Codable {
    /// title
    var rainmaker: String = ""
    /// txt
    var emanuel: String = ""
}
