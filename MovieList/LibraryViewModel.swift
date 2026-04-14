//
//  LibraryViewModel.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/14/26.
//

import Foundation
import SwiftData

@Observable
class LibraryViewModel {
    var newListTitle: String = ""
    
    func addList(_ modelContext: ModelContext) {
        let list = MovieList(name: newListTitle, movies: [])
        modelContext.insert(list)
        try? modelContext.save()
    }
}
