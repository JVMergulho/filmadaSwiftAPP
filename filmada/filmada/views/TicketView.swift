//
//  TicketView.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 18/05/24.
//

import SwiftUI

struct TicketView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    @Binding var isTicketVisible: Bool
    @Binding var reDo: Bool
    @Binding var searchLanguage: Language
    @Binding var answers: [Int]
    
    init(isTicketVisible: Binding<Bool>, reDo: Binding<Bool>, searchLanguage: Binding<Language>, answers: Binding<[Int]>) {
        self._isTicketVisible = isTicketVisible
        self._reDo = reDo
        self._searchLanguage = searchLanguage
        self._answers = answers
    }
    
    var body: some View {
        
        ZStack {
            Image(.ticket)
                .resizable()
                .frame(width: 394, height: 798)
            
            VStack {
                VStack{
                    Text("Nós recomendamos o seguinte filme")
                        .multilineTextAlignment(.center)
                        .font(.header1)
                        .lineLimit(nil)
                    
                    if let movie = viewModel.movie {
                        AsyncImage(url: movie.posterURL, content: { $0 }, placeholder: { Image(systemName: "photo")})
                            .frame(width: 180, height: 180)
                            .cornerRadius(24)
                            .padding(.bottom, 20)
                        
                        Text(movie.title)
                            .multilineTextAlignment(.center)
                            .font(.header1)
                            .lineLimit(nil)
                        
                        HStack{
                            Text(movie.releaseDate.split(separator: "-")[0])
                            Text("|")
                            Text(String(format: "%.2f", movie.voteAverage))
                            Image(systemName: "star.fill")
                                .frame(width: 16, height: 16)
                        }
                    } else {
                        ProgressView("loading...")
                    }
                }
                .padding(.top, 67)
                .frame(width: 224)
                .padding(.bottom, 30)
                VStack{
                    
                    if let movie = viewModel.movie {
                        Text(movie.overview!)
                            .frame(height: 150)
                    }
                    
                    HStack{
                        Button(action: {
                            clear()
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
                        
                        Button(action: {
                            viewModel.index += 1
                        })
                        {
                            Text("Outra Sugestão")
                        }
                        .frame(width: 112, height: 50)
                        .background(.btActive)
                        .cornerRadius(10)
                    }
                    .padding(.top, 30)
                }
                .padding(.bottom, 90)
                .frame(width: 248)
            }
        }
        .padding(.top, 40)
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .task {
            await loadMovie()
            viewModel.movies.shuffle()
            viewModel.index = 0
        }
        .animation(.easeInOut, value: viewModel.index)
    }
    
    func clear() {
        isTicketVisible = false
        reDo = true
    }
    
    func loadMovie() async {
        
        let runTime: Int
        var searchGenres: [String] = []
        
        
        switch answers[0]{
        case 0, 1:
            searchGenres.append("Drama")
        default:
            searchGenres.append("Comedy")
        }
        
        switch answers[1]{
        case 0, 1:
            searchGenres.append("Adventure")
        default:
            searchGenres.append("Romance")
        }
        
        switch answers[2]{
        case 0:
            runTime = 90
        case 1:
            runTime = 120
        default:
            runTime = 999
        }
        
        switch answers[3]{
        case 0:
            searchGenres.append("Music")
        case 1:
            searchGenres.append("Science Fiction")
        case 2:
            searchGenres.append("Western")
        default:
            searchGenres.append("Mystery")
        }
        
        await viewModel.makeQuery(searchGenres: searchGenres,
                                  searchLang: String(searchLanguage.rawValue),
                                  runTime: runTime)
    }
}

#Preview {
    TicketView(isTicketVisible: .constant(true), reDo: .constant(false), searchLanguage: .constant(.portuguese), answers: .constant([3,3,3,3]))
}
