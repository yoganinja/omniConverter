//
//  FavoritesPicker.swift
//  omniConverter
//
//  Created by John Florian on 1/8/25.
//

import SwiftUI

struct FavoritesPicker: View {
  @ObservedObject var appState: AppState
  var onSelect: (FavoriteConversion?) -> Void
  
  var body: some View {
    NavigationView {
      List {
        ForEach(appState.favoriteConversions, id: \.self) { favorite in
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
}
