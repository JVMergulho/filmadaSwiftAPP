//
//  TicketView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 18/05/24.
//

import SwiftUI

struct TicketView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    @State var myMovie: Movie?
    @Binding var isTicketVisible: Bool
    @Binding var reDo: Bool
    @Binding var searchLanguage: Language?
    @Binding var answers: [Int]
    
    init(isTicketVisible: Binding<Bool>, reDo: Binding<Bool>, searchLanguage: Binding<Language?>, answers: Binding<[Int]>) {
        self._isTicketVisible = isTicketVisible
        self._reDo = reDo
        self._searchLanguage = searchLanguage
        self._answers = answers
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
            viewModel.movies.shuffle()
            myMovie = viewModel.movies[0]
        }
    }
    
    func loadMovie() async {
        
        let runTime: Int
        
        if let searchLanguage{
            switch answers[answers.count - 1]{
                case 0:
                    runTime = 90
                case 1:
                    runTime = 120
                default:
                    runTime = 999
            }
            
            await viewModel.makeQuery(searchGenres: ["Action"],
                                      searchLang: String(searchLanguage.rawValue),
                                      runTime: runTime)
        }
    }
}

//#Preview {
//    TicketView()
//}
