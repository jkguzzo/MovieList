//
//  NewListView.swift
//  MovieList
//
//  Created by Julia Guzzo on 4/13/26.
//

import SwiftData
import SwiftUI

struct NewListView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var vm: LibraryViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Title")
                .font(.title2)
                .bold()
            TextField("Give your list a title", text: $vm.newListTitle)
                .textFieldStyle(.roundedBorder)
            Spacer()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.addList(modelContext)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(vm.newListTitle.isEmpty)
                }
            }
        }
        .padding()
        .navigationTitle("New List")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NewListView(vm: LibraryViewModel())
    }
}
