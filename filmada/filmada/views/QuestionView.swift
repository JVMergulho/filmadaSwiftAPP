//
//  questions.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 15/05/24.
//

import Foundation
import SwiftUI

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
                                            .lineLimit(3)
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(width: 167, height: 61)
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
        .shadow(color: .black, radius: 8, x: 0, y: 4)
        .padding(.top, 12)
    }
}
