//
//  UnitSelector.swift
//  omniConverter
//
//  Created by John Florian on 12/27/24.
//

import SwiftUI

struct UnitSelector: View {
  @Binding var isOpen: Bool
  var selectedConversionType: ConversionType
  @Binding var selectedUnit: String
  let units: [String]
  let onSelection: (String) -> Void
  
  var body: some View {
    Button(action: {
      isOpen.toggle()
    }) {
      HStack {
        Text("\(selectedUnit) (\(selectedUnit.unit(for: selectedConversionType)?.symbol ?? ""))")
        Spacer()
        Image(systemName: "chevron.down")
          .resizable()
          .frame(width: 24, height: 24)
          .padding(.top)
        //          .foregroundColor(.gray)
      }
      .padding(.vertical, 8)
    }
    .background(Color.white)
    .cornerRadius(8)
    
    if isOpen {
      VStack {
        ForEach(units, id: \.self) { unit in
          Button(action: {
            selectedUnit = unit
            isOpen = false
            onSelection(unit)
          }) {
            Text(unit)
          }
          .padding()
        }
      }
      .background(Color.white)
      .cornerRadius(8)
      .shadow(radius: 4)
      .padding()
    }
  }
}
