//
//  Question.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 17/05/24.
//

import Foundation

class Question {
    let text: String
    let alternatives: [String]
    
    init(text: String, alternatives: [String]) {
        self.text = text
        self.alternatives = alternatives
    }
}
