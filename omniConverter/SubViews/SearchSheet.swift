//
//  SearchSheet.swift
//  omniConverter
//
//  Created by John Florian on 1/8/25.
//

import SwiftUI

//typealias Suggestion = (conversionType: ConversionType, unit: String)
typealias Suggestion = (
  conversionType: ConversionType,
  displayValue: String, // For showing in the UI
  unitName: String // For returning the original unit name
)

struct SearchSheet: View {
  @Binding var searchText: String
  @Binding var suggestions: [Suggestion]
  
  var onSelect: (Suggestion?) -> Void
  
  var body: some View {
    NavigationView {
      List {
        ForEach(suggestions, id: \.unitName) { suggestion in
          Button(action: {
            onSelect((conversionType: suggestion.conversionType, displayValue: suggestion.displayValue, unitName: suggestion.unitName))
          }) {
            HStack {
              Text(suggestion.conversionType.rawValue)
              Spacer()
              Text(suggestion.displayValue) // Show the combined value in the UI
            }
          }
        }
      }
      .listStyle(PlainListStyle())
      .navigationTitle("Search Units")
      .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
      .textInputAutocapitalization(.never)
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
  
  private func filterSuggestions() {
    guard !searchText.isEmpty else {
      suggestions = []
      return
    }
    
    // Flatten all unit names and symbols combined with their corresponding ConversionType
    suggestions = ConversionType.allCases.flatMap { conversionType in
      // Combine names and symbols for display
      zip(conversionType.unitTypeNames, conversionType.unitTypeSymbols).map { name, symbol in
        (
          conversionType: conversionType,
          displayValue: "\(name) (\(symbol))", // For showing in the UI
          unitName: name // For internal use
        )
      }
      .filter { suggestion in
        suggestion.displayValue.localizedCaseInsensitiveContains(searchText)
      }
    }
  }
}
