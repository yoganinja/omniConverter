//
//  ContentView.swift
//  omniConverter
//
//  Created by John Florian on 12/20/24.
//

import SwiftUI

struct PlayView: View {
  let types = ConversionType.allCases
  let unitNames = ConversionType.length.unitTypeNames
  let units = Length.allUnitCases
  @State private var selectedConversionTypeUnits: [Unit]// = ConversionType.length.allUnitCases
  
  var body: some View {
//    ForEach(types, id: \.self) { type in
//      List {
//        ForEach(type.unitTypeNames) { unit in
//          Text("\(unit.id)")
//            .padding()
//        }
//      }
//    }
    
    ForEach(types, id: \.self) { type in
//      Text(type.id.unit?.symbol ?? "")
//      Text(type.unitType.debugDescription())
      
      List {
        ForEach(type.unitTypeNames, id: \.self) { unit in
          Text(unit)
            .padding()
        }
      }
    }
    
    List {
      ForEach(unitNames, id: \.self) { unit in
        Text(unit)
          .padding()
      }
    }
  }
}

struct ContentView: View {
  @State private var inputValue: String = "0"
  @State private var outputValue: String = "0"
//  @State private var selectedConversionTypeUnits: [Unit] = ConversionType.length.allUnitCases
  @State private var selectedConversionType: ConversionType = .length
  @State private var selectedInputUnit: String = "Inches"
  @State private var selectedOutputUnit: String = "Millimeters"
  @State private var isConversionTypeSelectorOpen: Bool = false
  @State private var isInputUnitSelectorOpen: Bool = false
  @State private var isOutputUnitSelectorOpen: Bool = false
  @State private var searchQuery: String = ""
  
  var body: some View {
    ZStack {
      VStack {
        // Conversion Type Section
        HStack {
          VStack(alignment: .leading) {
            Button(action: {
              isConversionTypeSelectorOpen.toggle()
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
                  .padding(.vertical)
              }
            }
            .padding(.vertical, 8)
            
          }
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top, 8)
        
        ZStack {
          VStack {
            // Input Section
            HStack {
              VStack(alignment: .leading) {
                Button(action: {
                  isInputUnitSelectorOpen.toggle()
                }) {
                  HStack {
                    Text("\(selectedInputUnit) (\(selectedInputUnit.unit(for: selectedConversionType)?.symbol ?? ""))")
//                      .font(.caption)
                    Spacer()
                    Image(systemName: "chevron.down")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .padding(.top)
                      .foregroundColor(.gray)
                  }
                }
                .padding(.vertical, 8)
                
                TextField("0", text: $inputValue)
                  .font(.largeTitle)
                  .keyboardType(.decimalPad)
                  .padding(.vertical, 4)
                  .disabled(true)
              }
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top)
            
            // Output Section
            HStack {
              VStack(alignment: .leading) {
                Button(action: {
                  isOutputUnitSelectorOpen.toggle()
                }) {
                  HStack {
                    Text("\(selectedOutputUnit) (\(selectedOutputUnit.unit(for: selectedConversionType)?.symbol ?? ""))")
//                      .font(.caption)
                    Spacer()
                    Image(systemName: "chevron.down")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .padding(.top)
                      .foregroundColor(.gray)
                  }
                }
                .padding(.vertical, 8)
                
                Text(outputValue)
                  .font(.largeTitle)
                  .padding(.vertical, 4)
              }
              Spacer()
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top, 8)
          }
          
          HStack {
            Spacer()
            
            Button(action: {
              // Swap input and output units
              let tempUnit = selectedInputUnit
              selectedInputUnit = selectedOutputUnit
              selectedOutputUnit = tempUnit
              
              let tempValue = inputValue
              inputValue = outputValue
              outputValue = tempValue
            }) {
              ZStack {
                Circle()
                  .fill(Color.gray.opacity(0.3)) // Background color for the circle
                  .frame(width: 50, height: 50) // Size of the circle
                
                Image(systemName: "arrow.up.arrow.down")
                  .resizable()
                  .frame(width: 24, height: 24)
                  .padding()
              }
            }
          }
          .padding()
        }
        
        Spacer()
        
        // Numeric Keyboard
        HStack {
          VStack {
            ForEach(["789C%", "456÷×", "123-+", ".0⌫±="], id: \.self) { row in
              HStack {
                ForEach(row.map { String($0) }, id: \.self) { key in
                  Button(action: {
                    handleKeyPress(key)
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
        .padding(.bottom)
      }
      
      // Conversion Type Selector Modal
      if isConversionTypeSelectorOpen {
        VStack {
          HStack {
            TextField("Search...", text: $searchQuery)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
            Button("Close") {
              isConversionTypeSelectorOpen = false
            }
            .padding(.trailing)
          }
          List {
            ForEach(ConversionType.allCases.filter {
              searchQuery.isEmpty || $0.id.lowercased().contains(searchQuery.lowercased())
            }, id: \.self) { type in
              Button(action: {
                if isConversionTypeSelectorOpen {
                  selectedConversionType = type
                  isConversionTypeSelectorOpen = false
                  
                  // Automatically set the input and output units based on the selected conversion type
//                  selectedConversionTypeUnits = type.allCases
                  
                  
                  if let firstUnit = selectedConversionType.unitTypeNames.map({$0}).first
                  {
                      selectedInputUnit = "\(firstUnit)"
                  }
                  if let secondUnit = selectedConversionType.unitTypeNames.dropFirst().first {
                      selectedOutputUnit = "\(secondUnit)"
                  } else if let secondUnit = selectedConversionType.unitTypeNames.map({$0}).first {
                    selectedOutputUnit = "\(secondUnit)"
                  }
                }
              }) {
                Text(type.id)
                  .padding()
              }
            }
          }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding()
        .transition(.opacity)
        .zIndex(1)
      }
      
      // Unit Selector Modal
      if isInputUnitSelectorOpen || isOutputUnitSelectorOpen {
        VStack {
          HStack {
            TextField("Search...", text: $searchQuery)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
            Button("Close") {
              isInputUnitSelectorOpen = false
              isOutputUnitSelectorOpen = false
            }
            .padding(.trailing)
          }
          List {
            ForEach(selectedConversionType.unitTypeNames.filter {
              searchQuery.isEmpty || $0.lowercased().contains(searchQuery.lowercased())
            }, id: \.self) { unit in
              Button(action: {
                if isInputUnitSelectorOpen {
                  selectedInputUnit = unit
                  isInputUnitSelectorOpen = false
                } else if isOutputUnitSelectorOpen {
                  selectedOutputUnit = unit
                  isOutputUnitSelectorOpen = false
                }
              }) {
                Text(unit)
                  .padding()
              }
            }
          }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding()
        .transition(.opacity)
        .zIndex(1)
      }
    }
    .background(Color.red.opacity(0.1).edgesIgnoringSafeArea(.all))
  }
  
  // Handle keyboard key press logic
  private func handleKeyPress(_ key: String) {
    switch key {
    case "C":
      inputValue = "0"
      outputValue = "0"
    case "⌫":
      inputValue = String(inputValue.dropLast())
      if inputValue.isEmpty { inputValue = "0" }
    default:
      if inputValue == "0" {
        inputValue = key
      } else {
        inputValue.append(key)
      }
    }
    calculateOutput()
  }
  
  // Convert the input value based on selected units
  private func calculateOutput() {
    guard let input = Double(inputValue) else {
      outputValue = "0"
      return
    }
    
    let conversionFactor: Double
    if selectedInputUnit == "Inch" && selectedOutputUnit == "Millimeter" {
      conversionFactor = 25.4
    } else if selectedInputUnit == "Millimeter" && selectedOutputUnit == "Inch" {
      conversionFactor = 0.0393701
    } else {
      conversionFactor = 1.0 // Handle similar units or extend logic for others
    }
    
    let result = input * conversionFactor
    outputValue = String(format: "%.2f", result)
  }
}

//#Preview {
//  ContentView()
//}
