//
//  ContentView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    
//    let questions: [Question] = [
//        Question(text: "1- Como você está hoje?", alternatives: ["Pulando de alegria", "Muito Bem", "Tô ok", "Meio para baixo"]),
//        Question(text: "2- Como está o seu nível de paciência?", alternatives: ["Xingando no trânsito", "Fila do banco", "Noite de sexta", "Monge budista"]),
//        Question(text: "3- Quão aventureiro você está?", alternatives: ["Explorador audacioso", "Aprendiz ansioso", "Observador atento", "Quero ficar debaixo do cobertor"])
//    ]
    
    let questions: [Question] = [
            Question(text: "1- Como você está hoje?", alternatives: ["Pulando de alegria", "Muito Bem", "Tô ok", "Meio para baixo"])]
    
    @State var pageNumber: Int = 0
    @State var buttonColors: [Color] = [.altGray, .altGray, .altGray, .altGray]
    let buttonColorsDefault: [Color] = [.altGray, .altGray, .altGray, .altGray]
    
    @State var rangeAge: Range?
    @State var selectedAlt: Int?
    @State var isTicketVisible: Bool = false
    
    var isDisabled: Bool {
        if pageNumber == 0{
            rangeAge == nil
        } else {
            selectedAlt == nil
        }
    }
    var body: some View {
        ZStack() {
            Color.bg
                .ignoresSafeArea(.all)
            
            VStack{
                
                ZStack{
                    Rectangle()
                        .fill(.blueHeader)
                        .frame(height: 180)
                        .cornerRadius(60)
                    VStack{
                        HStack{
                            Text("Filmada")
                                .font(.display)
                            Image(systemName: "movieclapper.fill")
                                .resizable()
                                .frame(width: 24, height: 25)
                        }
                        .padding(.top, 68)
                        
                        Text("O filme perfeito para seu mood")
                            .font(.header2)
                            .padding(.vertical, 25)
                    }
                }.frame(height: 175)
                
                VStack(alignment: .leading) {
                    
                    Button(action: {
                        if pageNumber > 0{
                            pageNumber -= 1
                        }
                    }){
                        Image(systemName: "arrow.backward")
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                                .foregroundColor( pageNumber == 0 ? .bg : .white)
                    }
                    
                    
                    VStack(){
                        
                        VStack {
                            switch pageNumber {
                            case 0:
                                AgeSelectionView(rangeAge: $rangeAge)
                            case 1...questions.count:
                                QuestionView(
                                    curQuestion: questions[pageNumber - 1],
                                    buttonColors: $buttonColors,
                                    selectedAlt: $selectedAlt
                                )
                            default:
                                QuestionView(
                                    curQuestion: questions[questions.count - 1],
                                    buttonColors: $buttonColors,
                                    selectedAlt: $selectedAlt
                                )
                            }
                        }
                        .onChange(of: pageNumber) { newValue in
                            if newValue > questions.count {
                                isTicketVisible = true
                                pageNumber = questions.count
                            }
                        }
                        
                        Button(action: {
                            pageNumber += 1
                            buttonColors = buttonColorsDefault
                            selectedAlt = nil
                        }){
                            Text("Próximo")
                                .frame(width: 163, height: 64)
                                .background(isDisabled ? .btInactive : .btActive)
                                .cornerRadius(10.0)
                        }
                        .shadow(color: Color.black.opacity(isDisabled ? 0 : 1), radius: 8, x: 0, y: 4)
                        .padding(.top, 40)
                        .disabled(isDisabled)
                        
                        HStack{
                            ForEach(0..<4){ index in
                                if index < pageNumber{
                                    Image(.popCorn)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                } else if index == pageNumber {
                                    Image(.popCorn)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                } else {
                                    Image(.cornKernel)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                            }
                        }
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .padding(.top, 40)
                        
                    }
                }
                .padding(.top, 12)
                
            }
            .edgesIgnoringSafeArea(.all)
            
            if isTicketVisible{
                TicketView(isTicketVisible: $isTicketVisible)
            }
        }
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
