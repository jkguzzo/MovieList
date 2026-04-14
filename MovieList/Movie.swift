//
//  Movie.swift
//  MovieList
//
//  Created by Julia Guzzo on 10/27/25.
//

import Foundation
import UIKit
import SwiftData

@Model
class Movie {
    @Attribute(.unique) var apiID: String
    var title: String
    var poster: String
    @Attribute(.externalStorage) var image: Data? = nil
    var status: WatchStatus? = nil
    var rated: String
    var rating: Int? = nil
    var review: String? = nil
    var lists: [MovieList] = []
    var addedAt = Date.now
    var year: String
    var released: String // use decoding strategy
    var runtime: String
    var genres: [String]
    var director: String
    var actors: [String]
    var plot: String
    
    init(apiID: String, title: String, posterURL: String, rated: String, status: WatchStatus? = nil, rating: Int? = nil, review: String? = nil, genres: [String], year: String, released: String, runtime: String, director: String, actors: [String], plot: String) {
        self.apiID = apiID
        self.title = title
        self.poster = posterURL
        self.rated = rated
        self.status = status
        self.rating = rating
        self.review = review
        self.genres = genres
        self.year = year
        self.released = released
        self.runtime = runtime
        self.director = director
        self.actors = actors
        self.plot = plot
        Task {
            self.image = try? await urlToData()
        }
    }
    
    init(from dto: MovieDTO, with watchStatus: WatchStatus? = nil) {
        self.apiID = dto.id
        self.title = dto.title
        self.poster = dto.poster
        self.rated = dto.rated
        self.status = watchStatus
        self.genres = dto.genre.components(separatedBy: ", ")
        self.year = dto.year
        self.released = dto.released
        self.runtime = dto.runtime
        self.director = dto.director
        self.actors = dto.actors.components(separatedBy: ", ")
        self.plot = dto.plot
        Task {
            self.image = try? await urlToData()
        }
    }
    
    private func urlToData() async throws -> Data? {
        guard let imageURL = URL(string: poster) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        return data
    }
}

enum WatchStatus: String, Codable, CaseIterable {
    case wantToWatch = "Want to Watch"
    case watched = "Watched"
}

enum FilterOptions: String, CaseIterable {
    case all = "All"
    case wantToWatch = "Want to Watch"
    case watched = "Watched"
}

enum Source {
    case url(String)
    case data(Data)
}

@Model
class MovieList {
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .nullify, inverse: \Movie.lists) var movies: [Movie] = []
    var createdAt = Date.now
    
    init(name: String, movies: [Movie]) {
        self.name = name
        self.movies = movies
    }
}

struct MovieDTO: Codable, Identifiable {
    let id: String
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let actors: String
    let plot: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbRating"
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case poster = "Poster"
    }
    
}

struct Search: Codable, Identifiable {
    let id = UUID()
    
    let search: [MovieSearch]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct MovieSearch: Codable, Identifiable, Hashable {
    
    let title: String
    let year: String
    let id: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}


extension MovieSearch {
    static let example = MovieSearch(title: "Interstellar", year: "2014", id: "tt0816692", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_SX300.jpg")
}

extension MovieDTO {
    static let example = MovieDTO(id: "1234", title: "Interstellar", year: "2014", rated: "PG-13", released: "07 Nov 2014", runtime: "169 min", genre: "Adventure, Drama, Sci-Fi", director: "Christopher Nolan", actors: "Matthew McConaughey, Anne Hathaway, Jessica Chastain, Matt Damon", plot: "When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft, along with a team of researchers, to find a new planet for humans.", poster: "https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_SX300.jpg")
}

extension Movie {
    static let example = Movie(from: MovieDTO.example)
}
