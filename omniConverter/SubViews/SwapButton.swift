//
//  SwapButton.swift
//  omniConverter
//
//  Created by John Florian on 12/27/24.
//

import SwiftUI

struct SwapButton: View {
  let onSwap: () -> Void
  
  var body: some View {
    Button(action: onSwap) {
      ZStack {
        Circle()
          .fill(Color(.systemGray4).opacity(0.5))
          .frame(width: 50, height: 50)
        Image(systemName: "arrow.up.arrow.down")
          .resizable()
          .frame(width: 24, height: 24)
      }
    }
  }
}
