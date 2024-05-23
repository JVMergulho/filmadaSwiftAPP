//
//  range.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 14/05/24.
//

import Foundation

enum Language: String, CaseIterable{
    case portuguese = "Português"
    case english = "Inglês"
    case spanish = "Espanhol"
    case french = "Francês"
    case italian = "Italiano"
    case german = "Alemão"
    case russian = "Russo"
    case mandarin = "Mandarim"
    case japonese = "Japonês"
    case korean = "Coreano"
}

let langCodes: [String: String] = [
    "Português": "pt",
    "Inglês": "en",
    "Espanhol": "es",
    "Francês": "fr",
    "Italiano": "it",
    "Alemão": "de",
    "Russo": "ru",
    "Mandarim": "zh",
    "Japonês": "ja",
    "Coreano": "ko"
]
