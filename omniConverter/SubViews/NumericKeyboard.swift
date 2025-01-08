//
//  NumericKeyboard.swift
//  omniConverter
//
//  Created by John Florian on 12/27/24.
//

import SwiftUI

struct NumericKeyboard: View {
  let onKeyPress: (String) -> Void
  let keys: [[String]] = [
    ["C", "±", "%", "÷"],
    ["7", "8", "9", "×"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    [".", "0", "⌫", "="]
  ]
  
  var body: some View {
    VStack {
      ForEach(keys, id: \.self) { row in
        HStack {
          ForEach(row, id: \.self) { key in
            Button(action: {
              onKeyPress(key)
            }) {
              Text(key)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, maxHeight: 64)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
            }
          }
        }
        .padding(.horizontal)
      }
    }
  }
}

//        // Numeric Keyboard
//        HStack {
//          VStack {
//            ForEach(["789C%", "456÷×", "123-+", ".0⌫±="], id: \.self) { row in
//              HStack {
//                ForEach(row.map { String($0) }, id: \.self) { key in
//                  Button(action: {
//                    handleKeyPress(key)
//                  }) {
//                    Text(key)
//                      .font(.largeTitle)
//                      .frame(maxWidth: .infinity, maxHeight: 64)
//                      .background(Color.gray.opacity(0.3))
//                      .cornerRadius(8)
//                  }
//                }
//              }
//              .padding(.horizontal)
//            }
//          }
//        }
//        .padding(.bottom)
