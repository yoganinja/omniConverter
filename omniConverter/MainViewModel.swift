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
  
  // for calculator functions
  @Published var firstOperand: Double? = nil
  @Published var currentOperator: String? = nil
  @Published var rawInputValue: String = "0"
}

extension MainViewModel {
  func updateConversionType() {
    selectedInputUnit = selectedConversionType.unitTypeNames.first ?? ""
    selectedOutputUnit = selectedConversionType.unitTypeNames.dropFirst().first
    ?? selectedConversionType.unitTypeNames.first ?? ""
    
    calculateOutput()
  }
  
  func updateInputUnit() {
    calculateOutput()
  }
  
  func updateOutputUnit() {
    calculateOutput()
  }
  
  func swapUnits() {
    let tempUnit = selectedInputUnit
    selectedInputUnit = selectedOutputUnit
    selectedOutputUnit = tempUnit
    
//    let tempValue = inputValue
//    inputValue = outputValue
//    outputValue = tempValue
//    
//    calculateOutput()
  }
  
  func handleKeyPress(_ key: String) {
    switch key {
    case "C":
      // Clear input and output
      rawInputValue = "0"
      inputValue = "0"
      outputValue = "0"
    case "⌫":
      // Remove the last character from raw input
      rawInputValue = String(rawInputValue.dropLast())
      if rawInputValue.isEmpty { rawInputValue = "0" }
      inputValue = formatInputValue(rawInputValue)
    case ".":
      // Allow only one decimal point in raw input
      if !rawInputValue.contains(".") {
        rawInputValue.append(key)
      }
      inputValue = formatInputValue(rawInputValue)
    case "%":
      // Convert raw input to percentage
      if let value = Double(rawInputValue.replacingOccurrences(of: ",", with: "")) {
        let result = value / 100
        rawInputValue = formatRawValue(result)
        inputValue = formatInputValue(rawInputValue)
      }
    case "±":
      // Toggle sign for raw input
      if let value = Double(rawInputValue.replacingOccurrences(of: ",", with: "")) {
        rawInputValue = formatRawValue(-value)
        inputValue = formatInputValue(rawInputValue)
      }
    case "÷", "×", "-", "+":
      // Handle operators (store current input and operator)
      if let value = Double(rawInputValue.replacingOccurrences(of: ",", with: "")) {
        firstOperand = value
        currentOperator = key
        rawInputValue = "0" // Clear input for the second operand
        inputValue = rawInputValue
      }
    case "=":
      // Perform calculation
      if let firstOperand = firstOperand,
         let secondOperand = Double(rawInputValue.replacingOccurrences(of: ",", with: "")),
         let result = calculateResult(firstOperand: firstOperand, secondOperand: secondOperand, operator: currentOperator) {
        rawInputValue = formatRawValue(result)
        inputValue = formatInputValue(rawInputValue)
        self.firstOperand = nil
        currentOperator = nil
      }
    default:
      // Handle numeric input
      if rawInputValue == "0" && key != "." {
        rawInputValue = key // Replace leading "0" with the new digit
      } else {
        rawInputValue.append(key)
      }
      inputValue = formatInputValue(rawInputValue)
    }
    
    calculateOutput()
  }
  
  private func formatRawValue(_ value: Double) -> String {
    let stringValue = String(value)
    
    // Split into whole number and fractional parts
    let parts = stringValue.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
    let wholeNumberPart = parts[0].replacingOccurrences(of: ",", with: "")
    let fractionalPart = parts.count > 1 && Int(parts[1]) ?? 0 > 0 ? "." + parts[1] : ""
    
    // Combine the formatted whole number with the fractional part
    return wholeNumberPart + fractionalPart
  }
  
  private func formatInputValue(_ value: String) -> String {
    // Split into whole number and fractional parts
    let parts = value.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
    let wholeNumberPart = parts[0].replacingOccurrences(of: ",", with: "")
    let fractionalPart = parts.count > 1 ? "." + parts[1] : ""
    
    // Format the whole number part with commas
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    
    let formattedWholeNumber = formatter.string(from: NSNumber(value: Double(wholeNumberPart) ?? 0)) ?? wholeNumberPart
    
    // Combine the formatted whole number with the fractional part
    return formattedWholeNumber + fractionalPart
  }
  
  private func formatNumber(_ value: Double, preserveDecimals: Bool? = nil) -> String {
    let formatter = NumberFormatter()
    
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = preserveDecimals ?? false ? 1 : 0
    formatter.maximumFractionDigits = 10 // Adjust as needed
    return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
  }
  
  private func calculateResult(firstOperand: Double, secondOperand: Double, operator op: String?) -> Double? {
    switch op {
    case "÷":
      return secondOperand == 0 ? nil : firstOperand / secondOperand
    case "×":
      return firstOperand * secondOperand
    case "-":
      return firstOperand - secondOperand
    case "+":
      return firstOperand + secondOperand
    default:
      return nil
    }
  }
  
  // Convert the input value based on selected units
  private func calculateOutput() {
    guard let input = Double(rawInputValue) else {
      outputValue = formatNumber(0)
      return
    }
    
    var result: Double = 0.0
    
    switch selectedConversionType {
    case .acceleration:
      result = Acceleration.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .angle:
      result = Angle.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .area:
      result = Area.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .concentrationMass:
      result = ConcentrationMass.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .density:
      result = Density.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .duration:
      result = Duration.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .electricCharge:
      result = ElectricCharge.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .length:
      result = Length.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .dispersion:
      result = Dispersion.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .electricCurrent:
      result = ElectricCurrent.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .electricPotentialDifference:
      result = ElectricPotentialDifference.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .electricResistance:
      result = ElectricResistance.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .energy:
      result = Energy.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .frequency:
      result = Frequency.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .fuelEfficiency:
      result = FuelEfficiency.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .illuminance:
      result = Illuminance.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .informationStorage:
      result = InformationStorage.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .mass:
      result = Mass.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .power:
      result = Power.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .pressure:
      result = Pressure.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .radiationDose:
      result = RadiationDose.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .radioactivity:
      result = Radioactivity.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .speed:
      result = Speed.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .temperature:
      result = Temperature.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .volume:
      result = Volume.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    }
    
    outputValue = formatNumber(result)
  }
}
