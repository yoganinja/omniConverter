//
//  SearchSheet.swift
//  omniConverter
//
//  Created by John Florian on 1/8/25.
//

import SwiftUI

typealias Suggestion = (conversionType: ConversionType, unit: String)

struct SearchSheet: View {
  @Binding var searchText: String
  @Binding var suggestions: [Suggestion]
  
  var onSelect: (Suggestion?) -> Void
  
  var body: some View {
    NavigationView {
      List {
        ForEach(suggestions, id: \.unit) { suggestion in
          Button(action: {
            onSelect(suggestion)
          }) {
            HStack {
              Text(suggestion.conversionType.rawValue)
              Spacer()
              Text(suggestion.unit)
            }
          }
        }
      }
      .listStyle(PlainListStyle())
      .navigationTitle("Search Units")
      .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
      .onChange(of: searchText) { _ in
        filterSuggestions()
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            onSelect(nil) // Handle cancellation
          }
        }
      }
    }
  }
  
  // Filter Suggestions
  private func filterSuggestions() {
    guard !searchText.isEmpty else {
      suggestions = []
      return
    }
    
    suggestions = ConversionType.allCases.flatMap { conversionType in
      conversionType.unitTypeNames.filter { unitName in
        unitName.localizedCaseInsensitiveContains(searchText)
      }
      .map { matchedUnit in
        (conversionType: conversionType, unit: matchedUnit)
      }
    }
  }
}
