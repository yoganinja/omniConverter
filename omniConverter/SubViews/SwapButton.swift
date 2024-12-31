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
          .fill(Color.gray.opacity(0.3))
          .frame(width: 50, height: 50)
        Image(systemName: "arrow.up.arrow.down")
          .resizable()
          .frame(width: 24, height: 24)
      }
    }
  }
}

//            Button(action: {
//              // Swap input and output units
//              let tempUnit = vm.selectedInputUnit
//              vm.selectedInputUnit = vm.selectedOutputUnit
//              vm.selectedOutputUnit = tempUnit
//
//              let tempValue = vm.inputValue
//              vm.inputValue = vm.outputValue
//              vm.outputValue = tempValue
//            }) {
//              ZStack {
//                Circle()
//                  .fill(Color.gray.opacity(0.3)) // Background color for the circle
//                  .frame(width: 50, height: 50) // Size of the circle
//
//                Image(systemName: "arrow.up.arrow.down")
//                  .resizable()
//                  .frame(width: 24, height: 24)
//                  .padding()
//              }
//            }