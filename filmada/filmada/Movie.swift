//
//  Movie.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 20/05/24.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let releaseDate: String
    let voteAverage: Double
    
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var index: Int = 0
    
    private var APIkey: String = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    
    var movie: Movie? {
        guard movies.count > 0  else {
            return nil
        }
        return movies[index % movies.count]
    }
    
    func makeQuery(searchGenres: [String], searchLang: String, runTime: Int) async {
        print("Enviou")
        
        var genres: String = ""
        
        for index in 0..<searchGenres.count{
            guard let genreCode = genreCodes[searchGenres[index]] else {
                print("Gênero não encontrado")
                return
            }
            
            if index == 0 {
                genres += String(genreCode)
            } else if index < searchGenres.count - 1{
                genres += "," + String(genreCode)
            } else {
                genres += "|" + String(genreCode)
            }
        }
        
        guard let langCode = langCodes[searchLang] else {
            print("Idioma não encontrado")
            return
        }

        let baseURL = "https://api.themoviedb.org/3/discover/movie"
        var components = URLComponents(string: baseURL)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "with_genres", value: genres),
            URLQueryItem(name: "with_original_language", value: langCode),
            URLQueryItem(name: "with_runtime.lte", value: String(runTime)),
        ]
        components.queryItems = queryItems
        
        await fetchMovies(urlComponents: components)
    }
    
    func fetchMovies(urlComponents: URLComponents) async{
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(APIkey, forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                print(movieResponse)
                DispatchQueue.main.async {
                    self.movies = movieResponse.results
                }
            } else {
                print("Error: \(response)")
            }
        } catch {
            print("Request failed with error: \(error)")
        }

    }
}

