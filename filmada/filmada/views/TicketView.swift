//
//  TicketView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 18/05/24.
//

import SwiftUI

struct TicketView: View {
    
    @State var movieTitle: String = "Cidade de Deus"
    @Binding var isTicketVisible: Bool
    
    init(isTicketVisible: Binding<Bool>) {
        self._isTicketVisible = isTicketVisible
    }
    
    var body: some View {
        
        ZStack{
            
            Image(.ticket)
                .resizable()
                .frame(width: 394, height: 798)
            
            VStack {
                VStack{
                    Text("Nós recomendamos o seguinte filme")
                        .font(.header1)
                        .padding(.bottom, 30)
                    
                    Rectangle()
                        .frame(width: 180, height: 180)
                        .cornerRadius(24)
                        .padding(.bottom, 30)
                    
                    Text(movieTitle)
                        .font(.header1)
                    
                    Text("2002 | 2:15h | +16")
                        .font(.body1)
                }
                .padding(.top, 67)
                .frame(width: 224)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack{
                    Button(action: {
                        isTicketVisible = false
                    }) {
                        Text("Refazer")
                            .frame(width: 112, height: 50)
                            .cornerRadius(10)
                            .foregroundColor(.btActive)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.btActive, lineWidth: 2)
                            )
                    }

                    
                    Spacer()
                    
                    Button(action: {
                        isTicketVisible = false
                    }){
                        Text("Outra Sugestão")
                    }
                    .frame(width: 112, height: 50)
                    .background(.btActive)
                    .cornerRadius(10)
                }
                .padding(.bottom, 90)
                .frame(width: 248)
            }
        }
        .frame(width: .infinity, height: .infinity)
        .foregroundColor(.white)
    }
}

//#Preview {
//    TicketView()
//}
