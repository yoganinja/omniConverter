//
//  ConversionTypePicker.swift
//  omniConverter
//
//  Created by John Florian on 12/27/24.
//

import SwiftUI

struct ConversionTypePicker: View {
  @Binding var isOpen: Bool
  @Binding var selectedConversionType: ConversionType
  let onSelection: (ConversionType) -> Void
  
  var body: some View {
    Button(action: {
      isOpen.toggle()
    }) {
      HStack(alignment: .center) {
        Image(systemName: selectedConversionType.imageName)
          .resizable()
          .frame(width: 24, height: 24)
          .padding(.vertical)
        Text(selectedConversionType.id)
          .font(.system(size: 32, weight: .bold))
          .padding(.top, 16)
          .padding(.bottom, 8)
        
        Spacer()
        Image(systemName: "chevron.down")
          .resizable()
          .frame(width: 24, height: 24)
          .padding(.vertical, 40)
      }
      .padding(.vertical, 8)
    }
    .background(Color.white)
    .cornerRadius(8)
  }
}
