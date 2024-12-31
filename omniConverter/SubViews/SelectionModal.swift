//
//  SelectionModal.swift
//  omniConverter
//
//  Created by John Florian on 12/28/24.
//

import SwiftUI

struct SelectionModal: View {
  @Binding var isOpen: [Bool]
  @Binding var searchQuery: String
  
  var body: some View {
    HStack {
      TextField("Search...", text: $searchQuery)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)
        .padding(.top)
      Button("Close") {
        for index in isOpen.indices {
          isOpen[index] = false
        }
      }
      .padding(.trailing)
    }
  }
}
