//
//  CalculatorView.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import SwiftUI

// MARK: - Calculator Button Model
struct CalculatorButton: Identifiable, Hashable {
  let id = UUID()
  let label: String
  let action: () -> Void
  
  // Explicit Equatable conformance
  static func == (lhs: CalculatorButton, rhs: CalculatorButton) -> Bool {
    lhs.id == rhs.id && lhs.label == rhs.label
  }
  
  // Manual hash function ignoring the `action` closure
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(label)
  }
}

// MARK: - Reusable Button View
struct CalculatorButtonView: View {
  let button: CalculatorButton
  
  var body: some View {
    Button(action: button.action) {
      Text(button.label)
        .font(.system(size: 24, weight: .bold, design: .rounded))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(8)
    }
    .padding(4)
  }
}

// MARK: - Reusable Grid View
struct CalculatorGridView: View {
  let buttons: [[CalculatorButton]]
  
  private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
  
  var body: some View {
    VStack {
      ForEach(buttons, id: \.self) { row in
        HStack {
          ForEach(row) { button in
            CalculatorButtonView(button: button)
          }
        }
      }
    }
    .padding()
  }
}

// MARK: - Main Calculator View
struct CalculatorView: View {
  var body: some View {
    CalculatorGridView(buttons: sampleButtons)
  }
  
  // Example Buttons
  private var sampleButtons: [[CalculatorButton]] {
    [
      [CalculatorButton(label: "7", action: { print("7 pressed") }),
       CalculatorButton(label: "8", action: { print("8 pressed") }),
       CalculatorButton(label: "9", action: { print("9 pressed") }),
       CalculatorButton(label: "÷", action: { print("Divide pressed") })],
      
      [CalculatorButton(label: "4", action: { print("4 pressed") }),
       CalculatorButton(label: "5", action: { print("5 pressed") }),
       CalculatorButton(label: "6", action: { print("6 pressed") }),
       CalculatorButton(label: "×", action: { print("Multiply pressed") })],
      
      [CalculatorButton(label: "1", action: { print("1 pressed") }),
       CalculatorButton(label: "2", action: { print("2 pressed") }),
       CalculatorButton(label: "3", action: { print("3 pressed") }),
       CalculatorButton(label: "-", action: { print("Subtract pressed") })],
      
      [CalculatorButton(label: "0", action: { print("0 pressed") }),
       CalculatorButton(label: ".", action: { print("Decimal pressed") }),
       CalculatorButton(label: "=", action: { print("Equals pressed") }),
       CalculatorButton(label: "+", action: { print("Add pressed") })]
    ]
  }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    CalculatorView()
  }
}
