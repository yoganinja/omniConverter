//
//  FavoritesView.swift
//  omniConverter
//
//  Created by John Florian on 1/8/25.
//

import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject var appState: AppState
  
  private let vm: MainViewModel
  private let isSelectorOpen: Binding<Bool>
  
  init(vm: MainViewModel, isSelectorOpen: Binding<Bool>) {
    self.vm = vm
    self.isSelectorOpen = isSelectorOpen
  }
  
  var body: some View {
    HStack {
      Button(action: {
        if appState.isFavorite {
          appState.removeFavorite()
        } else {
          appState.addFavorite()
        }
      }) {
        HStack {
          Image(systemName: appState.isFavorite ? "heart.fill" : "heart")
            .foregroundColor(appState.isFavorite ? .red : .blue)
        }
        .padding(10)
        .background(Capsule().fill(Color(.systemGray4)))
      }
      .buttonStyle(PlainButtonStyle())
      
      Button(action: {
        isSelectorOpen.wrappedValue = true
      }) {
        HStack {
          Text("Favorites")
            .font(.headline)
        }
        .padding(10)
        .background(Capsule().fill(Color(.systemGray4)))
      }
    }
    .padding(.horizontal)
    .sheet(isPresented: isSelectorOpen) {
      FavoritesPicker(
        onSelect: { selection in
          if let favorite = selection {
            appState.selectedConversionType = favorite.conversionType
            appState.selectedInputUnit = favorite.inputUnit
            appState.selectedOutputUnit = favorite.outputUnit
            vm.getLastUsedValue()
          }
          isSelectorOpen.wrappedValue = false
        }
      )
      .environmentObject(appState)
    }
  }
}
