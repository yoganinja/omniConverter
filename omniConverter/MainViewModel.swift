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
      outputValue = String(format: "%.2f", 0)
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

    outputValue = String(format: "%.2f", result)
  }
}

