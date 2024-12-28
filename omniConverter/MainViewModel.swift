//
//  MainViewModel.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import Foundation

class MainViewModel: ObservableObject {
  @Published var inputValue: String = "0"
  @Published var outputValue: String = "0"
  @Published var selectedConversionType: ConversionType = .length
  @Published var selectedInputUnit: String = "Inches"
  @Published var selectedOutputUnit: String = "Millimeters"
  @Published var isConversionTypeSelectorOpen: Bool = false
  @Published var isInputUnitSelectorOpen: Bool = false
  @Published var isOutputUnitSelectorOpen: Bool = false
  @Published var searchQuery: String = ""
  
  var availableUnits: [String] {
      selectedConversionType.unitTypeNames
  }
}

extension MainViewModel {
  func updateConversionType(to type: ConversionType) {
    selectedConversionType = type
    selectedInputUnit = type.unitTypeNames.first ?? ""
    selectedOutputUnit = type.unitTypeNames.dropFirst().first ?? ""
  }
  
  func swapUnits() {
    let tempUnit = selectedInputUnit
    selectedInputUnit = selectedOutputUnit
    selectedOutputUnit = tempUnit
    
//    let tempValue = inputValue
//    inputValue = outputValue
//    outputValue = tempValue
  }
  
  // Handle keyboard key press logic
  func handleKeyPress(_ key: String) {
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
