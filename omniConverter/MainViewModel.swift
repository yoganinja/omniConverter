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
    
    //    calculateOutput()
  }
  
  // Handle keyboard key press logic
  func handleKeyPress(_ key: String) {
    switch key {
    case "C":
      // Clear input and output
      inputValue = "0"
      outputValue = "0"
    case "⌫":
      // Remove the last character
      inputValue = String(inputValue.dropLast())
      if inputValue.isEmpty { inputValue = "0" }
    case ".":
      // Allow only one decimal point
      if !inputValue.contains(".") {
        inputValue.append(key)
      }
    case "%":
      // Convert input to percentage
      if let value = Double(inputValue) {
        inputValue = String(value / 100)
      }
    case "±":
      // Toggle sign
      if let value = Double(inputValue) {
        inputValue = String(-value)
      }
    case "÷", "×", "-", "+":
      // Handle operators (store current input and operator)
      if let value = Double(inputValue) {
        firstOperand = value
        currentOperator = key
        inputValue = "0" // Clear input for the second operand
      }
    case "=":
      // Perform calculation
      if let firstOperand = firstOperand,
         let secondOperand = Double(inputValue),
         let result = calculateResult(firstOperand: firstOperand, secondOperand: secondOperand, operator: currentOperator ?? "") {
        inputValue = String(result)
        self.firstOperand = nil
        currentOperator = nil
      }
    default:
      // Handle numeric input
      if inputValue == "0" && key != "." {
        inputValue = key // Replace leading "0" with the new digit
      } else {
        inputValue.append(key)
      }
    }
    calculateOutput()
  }
  
  private func calculateResult(firstOperand: Double, secondOperand: Double, operator op: String) -> Double? {
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
    guard let input = Double(inputValue) else {
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
  
  private func formatNumber(_ value: Double) -> String {
    if value.truncatingRemainder(dividingBy: 1) == 0 {
      // If the value is a whole number, show no decimal places
      return String(format: "%.0f", value)
    } else {
      // If the value has significant decimal digits, show all significant digits
      return String(value)
    }
  }
}
