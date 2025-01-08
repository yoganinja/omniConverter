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
        ForEach(appState.favoriteConversions.sorted(by: {
          if $0.conversionType.id != $1.conversionType.id {
            return $0.conversionType.id < $1.conversionType.id
          } else if $0.inputUnit != $1.inputUnit {
            return $0.inputUnit < $1.inputUnit
          } else {
            return $0.outputUnit < $1.outputUnit
          }
        }), id: \.self) { favorite in
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
