//
//  ListDetailViewModel.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/14/26.
//

import Foundation
import SwiftData

@Observable
class ListDetailViewModel {
    var list: MovieList
    var filter: FilterOptions = .all
    var searchText: String = ""
    var showRenamePopover: Bool = false
    var newTitle: String = ""
    var deleteAlert: Bool = false
    var movies: [Movie] {
        switch filter {
        case .all:
            if searchText.isEmpty {
                return list.movies
            } else {
                return list.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            }
        case .wantToWatch:
            if searchText.isEmpty {
                return list.movies.filter { $0.status == .wantToWatch }
            } else {
                return list.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) && $0.status == .wantToWatch }
            }
        case .watched:
            if searchText.isEmpty {
                return list.movies.filter { $0.status == .wantToWatch }
            } else {
                return list.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) && $0.status == .watched }
            }
        }
    }
    
    init(list: MovieList) {
        self.list = list
    }
    
    func setDelete() {
        deleteAlert = true
    }
    
    func renameList(_ modelContext: ModelContext) {
        list.name = newTitle
        try? modelContext.save()
    }
    
    func deleteList(_ modelContext: ModelContext) {
        modelContext.delete(list)
        try? modelContext.save()
    }
}
