//
//  FavoritesPicker.swift
//  omniConverter
//
//  Created by John Florian on 1/8/25.
//

import SwiftUI

struct FavoritesPicker: View {
  @EnvironmentObject var appState: AppState
  @State private var isAscending = true
  
  var onSelect: (FavoriteConversion?) -> Void
  
  var body: some View {
    NavigationView {
      VStack {
        Button(action: {
          isAscending.toggle()
        }) {
          HStack {
            Image(systemName: isAscending ? "arrow.up" : "arrow.down")
            Text("Sort \(isAscending ? "Ascending" : "Descending")")
          }
          .padding()
          .background(Capsule().fill(Color(.systemGray4)))
        }
        .padding()
        
        List {
          ForEach(
            sortedFavorites(),
            id: \.self
          ) { favorite in
            Button(action: {
              onSelect(favorite)
            }) {
              HStack {
                Text("\(favorite.conversionType.id)")
                Spacer()
                Text("\(favorite.inputUnit) → \(favorite.outputUnit)")
              }
            }
          }
        }
      }
      .navigationTitle("Favorites")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Close") {
            onSelect(nil)
          }
        }
      }
    }
  }
  
  private func sortedFavorites() -> [FavoriteConversion] {
    appState.favoriteConversions.sorted {
      if $0.conversionType.id != $1.conversionType.id {
        return isAscending
        ? $0.conversionType.id < $1.conversionType.id
        : $0.conversionType.id > $1.conversionType.id
      } else if $0.inputUnit != $1.inputUnit {
        return isAscending
        ? $0.inputUnit < $1.inputUnit
        : $0.inputUnit > $1.inputUnit
      } else {
        return isAscending
        ? $0.outputUnit < $1.outputUnit
        : $0.outputUnit > $1.outputUnit
      }
    }
  }
}
