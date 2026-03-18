//
//  LDUserModel.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/16.
//

import Foundation

struct LDUserModel: Codable {
    var mathematicians: [LDUserMathematiciansModel] = []
    var userInfo: LDUserInfo = LDUserInfo()
}

struct LDUserMathematiciansModel: Codable {
    /// title
    var rainmaker: String = ""
    /// url
    var infinity: String = ""
    /// icon
    var centuries: String = ""
}

struct LDUserInfo: Codable {
    var kate: String = ""
}
