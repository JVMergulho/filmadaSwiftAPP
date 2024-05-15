//
//  ContentView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    
    let questions: [Question] = [
        Question(text: "Como você está hoje?", alternatives: ["Pulando de alegria", "Muito Bem", "Tô ok", "Meio para baixo"]),
        Question(text: "Como está o seu nível de paciência?", alternatives: ["Xingando no trânsito", "Fila do banco", "Noite de sexta", "Monge budista"]),
        Question(text: "Quão aventureiro você está?", alternatives: ["Explorador audacioso", "Apreendiz ansioso", "Observador atento", "Quero ficar debaixo do cobertor"])
    ]
    
    @State var pageNumber: Int = 0
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack{
                VStack(){
                    
                    // selecionar o conteúdo da vstack de acordo com pagenumber
                    if pageNumber == 0{
                        AgeSelectionView()
                    } else if pageNumber <= questions.count {
                        QuestionView(curQuestion: questions[pageNumber - 1])
                    }
                    
                    Button(action: {
                        pageNumber += 1
                    }){
                        Text("Próximo")
                            .frame(width: 163, height: 64)
                            .background(.orange)
                            .cornerRadius(10.0)
                    }
                    .padding(.top, 48)
                }
                
            }
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ContentView()
}
