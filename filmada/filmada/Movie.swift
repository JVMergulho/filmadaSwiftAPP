//
//  Movie.swift
//  filmada
//
//  Created by João Vitor Lima Mergulhão on 20/05/24.
//

import SwiftUI

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

var movie: Movie? = nil
let genreCodes: [String: Int] = [
    "Action": 28,
    "Adventure": 12,
    "Animation": 16,
    "Comedy": 35,
    "Crime": 80,
    "Documentary": 99,
    "Drama": 18,
    "Family": 10751,
    "Fantasy": 14,
    "History": 36,
    "Horror": 27,
    "Music": 10402,
    "Mystery": 9648,
    "Romance": 10749,
    "Science Fiction": 878,
    "TV Movie": 10770,
    "Thriller": 53,
    "War": 10752,
    "Western": 37
]

func makeQuery(searchGenre: String, searchLang: String) async {
    print("Enviou")
    
    guard let genreCode = genreCodes[searchGenre.capitalized] else {
        print("Gênero não encontrado")
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
        URLQueryItem(name: "with_genres", value: String(genreCode)),
        URLQueryItem(name: "with_original_language", value: searchLang)
    ]
    components.queryItems = queryItems

    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.setValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NDY0NGM5ZGE4YzZmZDM2OWM1YjhmOTMyMzczN2JmZSIsInN1YiI6IjY2NGE2ZjA4MGVkZGUyYzEzZGVkMDFmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7OUyhKvVyLuRy4OJZIBvN61PjOhumMcAEPKNX68A9sA", forHTTPHeaderField: "Authorization")

    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            print(movieResponse)
            if let firstMovie = movieResponse.results.first {
                DispatchQueue.main.async {
                    movie = firstMovie
                }
            }
        } else {
            print("Error: \(response)")
        }
    } catch {
        print("Request failed with error: \(error)")
    }
}


func getMovie(searchGenre: String, searchLang: String) async -> Movie? {
    await makeQuery(searchGenre: searchGenre, searchLang:searchLang)
    return movie
}
