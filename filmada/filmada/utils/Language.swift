//
//  range.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 14/05/24.
//

import Foundation

enum Language: String, CaseIterable{
    case lang1 = "Português"
    case lang2 = "Inglês"
    case lang3 = "Espanhol"
    case lang4 = "Francês"
    case lang5 = "Italiano"
    case lang6 = "Alemão"
    case lang7 = "Russo"
    case lang8 = "Mandarim"
    case lang9 = "Japonês"
    case lang10 = "Coreano"
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
