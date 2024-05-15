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
    @State var rangeAge: Range = .range1
    
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
                ForEach(Range.allCases, id: \.self) { range in
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
    @State var buttonColors: [Color] = [.blue, .blue, .blue, .blue]
    let curQuestion: Question
    
    init(curQuestion: Question) {
        self.curQuestion = curQuestion
    }
    
    var body: some View {
        VStack{
            Text(curQuestion.text)
                .font(.header2)
                .padding()
            
            Spacer()
            
            ForEach(0..<curQuestion.alternatives.count) { index in
                Button(action: {
                    if buttonColors[index] == .blue{
                        buttonColors[index] = .yellow
                    } else{
                        buttonColors[index] = .blue
                    }
                    print("Alternativa selecionada: \(curQuestion.alternatives[index])")
                }) {
                    HStack{
                        Image(systemName: "a")
                        Text(curQuestion.alternatives[index])
                            .padding()
                    }
                }
                .frame(width: 292, height: 61)
                .background(buttonColors[index])
                .cornerRadius(16)
                .foregroundColor(.white)
                .font(.body1)
            }
        }
        .frame(width: 345, height: 398)
        .background(.gray)
        .cornerRadius(16.0)
    }
}
