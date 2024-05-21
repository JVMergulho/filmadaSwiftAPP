//
//  TicketView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 18/05/24.
//

import SwiftUI

struct TicketView: View {
    
    @State var myMovie: Movie?
    @Binding var isTicketVisible: Bool
    @Binding var reDo: Bool
    @Binding var searchLanguage: Language?
    
    init(isTicketVisible: Binding<Bool>, reDo: Binding<Bool>, searchLanguage: Binding<Language?>) {
        self._isTicketVisible = isTicketVisible
        self._reDo = reDo
        self._searchLanguage = searchLanguage
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
                    
                    if let myMovie {
                        AsyncImage(url: myMovie.posterURL, content: { $0 }, placeholder: { Image(systemName: "photo")})
                        .frame(width: 180, height: 180)
                        .cornerRadius(24)
                        .padding(.bottom, 30)
                        Text(myMovie.title)
                            .font(.header1)
                        
                        HStack{
                            Text(myMovie.releaseDate.split(separator: "-")[0])
                            Text("|")
                            Text(String(format: "%.2f", myMovie.voteAverage))
                            Image(systemName: "star.fill")
                                .frame(width: 16, height: 16)
                        }
                    } else {
                        ProgressView("loading...")
                    }
                }
                .padding(.top, 67)
                .frame(width: 224)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack{
                    
                    if let myMovie {
                        Text(myMovie.overview!.truncated(to: 150))
                    }
                    
                    HStack{
                        Button(action: {
                            isTicketVisible = false
                            reDo = true
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
                }
                .padding(.bottom, 90)
                .frame(width: 248)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .task {
            await loadMovie()
        }
    }
    
    func loadMovie() async {
        if let searchLanguage{
            myMovie = await getMovie(searchGenre: "Adventure", searchLang: searchLanguage.rawValue)
        }
    }
}

//#Preview {
//    TicketView()
//}
