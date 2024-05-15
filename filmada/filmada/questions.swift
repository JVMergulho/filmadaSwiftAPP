//
//  questions.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 15/05/24.
//

import Foundation
import SwiftUI

class Question {
    let text: String
    let alternatives: [String]
    
    init(text: String, alternatives: [String]) {
        self.text = text
        self.alternatives = alternatives
    }
}

struct AgeSelectionView: View {
    @State var rangeAge: Int = 0
    
    var body: some View {
        VStack{
            
            Text("Selecione sua faixa de idade")
                .font(.header2)
                .padding([.top, .leading, .trailing], 27.0)
            
            
            Spacer()
            
            Text("Essa informação será importante para que possamos recomendar filmes adequados para você")
                .font(.body1)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 27.0)
            
            Spacer()
            
            Picker("Range", selection: $rangeAge) {
                ForEach(Size.allCases, id: \.self) { range in
                    Text("\(range.rawValue)")
                        .tag(range)
                }
            }
            .padding(.bottom, 110)
        }
        .frame(width: 345, height: 398)
        .background(.gray)
        .cornerRadius(16.0)
    }
}

struct QuestionView: View {
    
    @State var buttonColor: Color = .blue
    let curQuestion: Question
    
    init(curQuestion: Question) {
        self.curQuestion = curQuestion
    }
    
    var body: some View {
        VStack{
            Text(curQuestion.text)
                .font(.headline)
                .padding()
            
            Spacer()
            
            ForEach(0..<curQuestion.alternatives.count) { index in
                Button(action: {
                    buttonColor = .yellow
                    print("Alternativa selecionada: \(curQuestion.alternatives[index])")
                }) {
                    Text(curQuestion.alternatives[index])
                        .font(.body1)
                        .padding()
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .font(.header2)
                }
                .padding(.bottom, 10)
            }
        }
        .frame(width: 345, height: 398)
        .background(.gray)
        .cornerRadius(16.0)
    }
}
