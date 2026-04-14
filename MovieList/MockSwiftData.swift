//
//  MockSwiftData.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/13/26.
//

import Foundation
import SwiftData

class MockSwiftData {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Movie.self, MovieList.self, configurations: config)
            
            let ted = Movie(apiID: "tt1637725", title: "Ted", posterURL: "https://m.media-amazon.com/images/M/MV5BMTQ1OTU0ODcxMV5BMl5BanBnXkFtZTcwOTMxNTUwOA@@._V1_SX300.jpg", rated: "R", genres: ["Comedy"], year: "2012", released: "29 Jun 2012", runtime: "106 min", director: "Seth MacFarlane", actors: ["Mark Wahlberg", "Mila Kunis", "Seth MacFarlane"], plot: "John Bennett, a man whose childhood wish of bringing his teddy bear to life came true, now must decide between keeping the relationship with the bear, Ted or his girlfriend, Lori.")
            let borat = Movie(apiID: "tt0443453", title: "Borat", posterURL: "https://m.media-amazon.com/images/M/MV5BMTk0MTQ3NDQ4Ml5BMl5BanBnXkFtZTcwOTQ3OTQzMw@@._V1_SX300.jpg", rated: "R", genres: ["Comedy"], year: "2006", released: "03 Nov 2006", runtime: "84 min", director: "Larry Charles", actors: ["Sacha Baron Cohen", "Ken Davitian", "Luenell"], plot: "Kazakh TV talking head Borat is dispatched to the United States to report on the greatest country in the world.")
            let avengers = Movie(apiID: "tt0848228", title: "The Avengers", posterURL: "https://m.media-amazon.com/images/M/MV5BNGE0YTVjNzUtNzJjOS00NGNlLTgxMzctZTY4YTE1Y2Y1ZTU4XkEyXkFqcGc@._V1_SX300.jpg", rated: "PG-13", genres: ["Action", "Sci-Fi"], year: "2012", released: "04 May 2012", runtime: "143 min", director: "Joss Whedon", actors: ["Robert Downey Jr.", "Chris Evans", "Scarlett Johansson"], plot: "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.")
            let someoneGreat = Movie(apiID: "tt8075260", title: "Someone Great", posterURL: "https://m.media-amazon.com/images/M/MV5BMjI5MzQ0NjA5Ml5BMl5BanBnXkFtZTgwNjA1MTg1NzM@._V1_SX300.jpg", rated: "R", genres: ["Comedy", "Romance"], year: "2019", released: "19 Apr 2019", runtime: "92 min", director: "Jennifer Kaytin Robinson", actors: ["Gina Rodriguez", "LaKeith Stanfield", "Brittany Snow"], plot: "After a devastating break up on the eve of her cross-country move, Jenny enjoys one last NYC adventure with her two best pals. Someone Great is a romantic comedy about love, loss, growth and the everlasting bond of female friendship.")
            let americanPie = Movie(apiID: "tt0163651", title: "American Pie", posterURL: "https://m.media-amazon.com/images/M/MV5BMTg3ODY5ODI1NF5BMl5BanBnXkFtZTgwMTkxNTYxMTE@._V1_SX300.jpg", rated: "R", genres: ["Comedy"], year: "1999", released: "09 Jul 1999", runtime: "95 min", director: "Paul Weitz", actors: ["Jason Biggs", "Chris Klein", "Thomas Ian Nicholas"], plot: "Four teenage boys enter a pact to lose their virginity by prom night.")
            let anchorman = Movie(apiID: "tt0357413", title: "Anchorman: The Legend of Ron Burgundy", posterURL: "https://m.media-amazon.com/images/M/MV5BMTQ2MzYwMzk5Ml5BMl5BanBnXkFtZTcwOTI4NzUyMw@@._V1_SX300.jpg", rated: "PG-13", genres: ["Comedy"], year: "2004", released: "09 Jul 2004", runtime: "94 min", director: "Adam McKay", actors: ["Will Ferrell", "Christina Applegate", "Steve Carell"], plot: "In the 1970s, an anchorman's stint as San Diego's top-rated newsreader is challenged when an ambitious newswoman becomes his co-anchor.")
            let meg = Movie(apiID: "tt4779682", title: "The Meg", posterURL: "https://m.media-amazon.com/images/M/MV5BMWZjYjgxMzEtYTE1MS00M2RlLWJjOTUtZDA5ODM2YWQ4Y2FhXkEyXkFqcGc@._V1_SX300.jpg", rated: "PG-13", genres: ["Action", "Adventure", "Horror"], year: "2018", released: "10 Aug 2018", runtime: "113 min", director: "Jon Turteltaub", actors: ["Jason Statham", "Bingbing Li", "Rainn Wilson"], plot: "A rescue mission to the bottom of the ocean is terrorized by a massive prehistoric shark.")
            
            let list1 = MovieList(name: "Comedy", movies: [ted, borat, americanPie, anchorman])
            let list2 = MovieList(name: "Action", movies: [avengers, meg])
            let list3 = MovieList(name: "Comfort Movies", movies: [someoneGreat, americanPie])
            
            container.mainContext.insert(list1)
            container.mainContext.insert(list2)
            container.mainContext.insert(list3)
            
            return container
        } catch {
            fatalError("Failed to create mock container")
        }
    }()
}
