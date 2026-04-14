//
//  MovieService.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/6/26.
//

import Foundation

protocol MovieServiceImpl {
    func searchMovies(title: String) async throws -> Search
    func fetchMovie(title: String) async throws -> MovieDTO
}

class MovieService: MovieServiceImpl {
    
    static let shared = MovieService()
    
    func searchMovies(title: String) async throws -> Search {
        let url = "https://www.omdbapi.com/?s=\(title)&apikey=b945d02d"
        
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return Search(search: [])
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
                
        do {
            let response = try decoder.decode(Search.self, from: data)
            return response
        } catch {
            print(error.localizedDescription)
        }
        
        return Search(search: [])
    }
    
    func fetchMovie(title: String) async throws -> MovieDTO {
        let url = "https://www.omdbapi.com/?t=\(title)&apikey=b945d02d"
        
        guard let url = URL(string: url) else {
            print("Invalid URL")
            throw MovieError.urlError
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .custom
                
        do {
            let response = try decoder.decode(MovieDTO.self, from: data)
            return response
        } catch {
            print(error.localizedDescription)
            throw MovieError.decodingError
        }
        
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static let custom: JSONDecoder.DateDecodingStrategy = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return .formatted(formatter)
    }()
}

enum MovieError: Error {
    case decodingError
    case urlError
    case invalidResponse
}
