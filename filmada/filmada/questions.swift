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
    @Binding var rangeAge: Range?
    
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
                        .tag(range as Range?)
                }
            }
            .padding(.bottom, 110)
        }
        .frame(width: 345, height: 398)
        .background(.boxGray)
        .cornerRadius(16.0)
        .padding(.top, 48)
    }
}

struct QuestionView: View {
    
    @Binding var buttonColors: [Color]
    @Binding var selectedAlt: Int?
    let curQuestion: Question
    
    init(curQuestion: Question, buttonColors: Binding<[Color]>, selectedAlt: Binding<Int?>) {
        self.curQuestion = curQuestion
        self._buttonColors = buttonColors
        self._selectedAlt = selectedAlt
    }
    
    var body: some View {
        VStack{
            Text(curQuestion.text)
                .multilineTextAlignment(.center)
                .font(.header2)
                .padding(.top, 27)
                .padding([.leading, .trailing], 57)

            Spacer()
            
            VStack{
                ForEach(0..<curQuestion.alternatives.count) { index in
                                Button(action: {
                                    if buttonColors[index] == .altGray{
                                        for idx in 0..<buttonColors.count{
                                            if buttonColors[idx] == .btActive{
                                                buttonColors[idx] = .altGray
                                            }
                                        }
                                            
                                        buttonColors[index] = .btActive
                                        selectedAlt = index
                                    } else{
                                        buttonColors[index] = .altGray
                                        selectedAlt = nil
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
            .padding(.bottom, 38)
            
        }
        .frame(width: 345, height: 398)
        .background(.boxGray)
        .cornerRadius(16.0)
        .padding(.top, 48)
    }
}

let auxQuestion = Question(text: "Quão aventureiro você está?", alternatives: ["Explorador audacioso", "Apreendiz ansioso", "Observador atento", "Quero ficar debaixo do cobertor"])

//#Preview {
//    QuestionView(curQuestion: auxQuestion)
//}
