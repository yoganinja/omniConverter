//
//  FavoritesPicker.swift
//  omniConverter
//
//  Created by John Florian on 1/8/25.
//

import SwiftUI

struct FavoritesPicker: View {
  @EnvironmentObject var appState: AppState
  
  var onSelect: (FavoriteConversion?) -> Void
  
  var body: some View {
    NavigationView {
      List {
        HStack {
          Spacer()
          Button(action: {
            appState.isFavoritesSortedAscending.toggle()
          }) {
            HStack {
              Text("Sort")
                .font(.title2)
              Image(systemName: appState.isFavoritesSortedAscending ? "arrow.up" : "arrow.down")
            }
          }
          .padding(.vertical, 5)
          Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Capsule().fill(Color(.systemGray6)))
        .listRowSeparator(Visibility.hidden)
        
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
        return appState.isFavoritesSortedAscending
        ? $0.conversionType.id < $1.conversionType.id
        : $0.conversionType.id > $1.conversionType.id
      } else if $0.inputUnit != $1.inputUnit {
        return appState.isFavoritesSortedAscending
        ? $0.inputUnit < $1.inputUnit
        : $0.inputUnit > $1.inputUnit
      } else {
        return appState.isFavoritesSortedAscending
        ? $0.outputUnit < $1.outputUnit
        : $0.outputUnit > $1.outputUnit
      }
    }
  }
}
