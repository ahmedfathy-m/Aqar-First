//
//  Len.swift
//  Aqar First
//
//  Created by Mina Mohareb on 24/09/2022.
//

import Foundation

enum LanguageItem{
    case arabic
    case english
    
    var code:String {
        switch self {
        case .arabic:
            return "ar"
        case .english:
            return "en"
        }
    }
    var title:String {
        switch self {
        case .arabic:
            return "Arabic"
        case .english:
            return "English"
        }
    }
    init(_ language : String) {
        switch (language) {
        case LanguageItem.arabic.code:    self = .arabic
        case LanguageItem.english.code: self = .english
        default:
            self = .english
        }
    }
}
