//
//  Setting.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 03/08/2023.
//

import Foundation

enum SettingType: CaseIterable {
    case setting
    case termOfPrivacy
    case sendFeedback
    case help
    case switchAccount
    case cancel

    var model: Setting {
        switch self {
        case .setting:
            return Setting(name: "Settings", nameImage: "setting")
        case .termOfPrivacy:
            return Setting(name: "Term & privacy policy", nameImage: "term")
        case .sendFeedback:
            return Setting(name: "Send feedback", nameImage: "feedback")
        case .help:
            return Setting(name: "Help", nameImage: "help")
        case .switchAccount:
            return Setting(name: "Switch account", nameImage: "account")
        case .cancel:
            return Setting(name: "Cancel", nameImage: "cancel")
        }
    }
}

struct Setting {
    let name: String
    let nameImage: String
}
