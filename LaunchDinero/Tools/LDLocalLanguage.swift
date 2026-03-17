//
//  LDLocalLanguage.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/13.
//

import Foundation

enum LDLocalLanguageType: String {
    case en
    case es
}

class LDLocalLanguage {
    static let shared = LDLocalLanguage()
    var mainBundle = Bundle.main
    var localLanguage: LDLocalLanguageType = .en
    func configLanguage(type: LDLocalLanguageType) {
        if let path = Bundle.main.path(forResource: type.rawValue, ofType: "lproj"), let bundle = Bundle(path: path) {
            mainBundle = bundle
            localLanguage = type
        }
    }
    func languageString(key: String) -> String {
        mainBundle.localizedString(forKey: key, value: nil, table: "Localizable")
    }
}

func LDText(key: String) -> String {
    return LDLocalLanguage.shared.languageString(key: key)
}
