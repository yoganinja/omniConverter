//
//  MainViewModel.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import Foundation

//protocol ConvertibleUnit {
//  associatedtype UnitType: Dimension
//  static func convert(value: Double, from inputUnit: UnitType, to outputUnit: UnitType) -> Double
//}

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
    
    calculateOutput()
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
  
//  private func resolveUnit(from unitName: String, for type: ConversionType) -> Dimension? {
//      switch type {
//      case .length:
//        
//        
//        if let aaa = UnitLength.allUnits[unitName] {
//          return aaa
//        } else {
//          return nil
//        }
//        
//        
//        
//        
//        
////          switch unitName {
////          case "Inches": return UnitLength.inches
////          case "Millimeters": return UnitLength.millimeters
////          case "Centimeters": return UnitLength.centimeters
////          case "Meters": return UnitLength.meters
////          case "Nanometers": return UnitLength.nanometers
////          default: return nil
////          }
//      case .duration:
//          switch unitName {
//          case "Hours": return UnitDuration.hours
//          case "Minutes": return UnitDuration.minutes
//          case "Seconds": return UnitDuration.seconds
//          default: return nil
//          }
//      default:
//          return nil
//      }
//  }

//  private func resolveUnit(from unitName: String, for type: ConversionType) -> Dimension? {
//    let inputMeasurement = Measurement(value: 1, unit: UnitLength.inches)
//    let outputMeasurement = inputMeasurement.converted(to: UnitLength.millimeters)
//    print(outputMeasurement.value) // Should print 25.4
//
//      switch type {
//      case .length:
//          return UnitLength(symbol: unitName)
//      case .duration:
//          return UnitDuration(symbol: unitName)
//      default:
//          return nil
//      }
//  }

  // Convert the input value based on selected units
  private func calculateOutput() {
    guard let input = Double(inputValue) else {
      outputValue = String(format: "%.2f", 0)
      return
    }
    
//        guard let inputUnit = resolveUnit(from: selectedInputUnit, for: selectedConversionType),
//              let outputUnit = resolveUnit(from: selectedOutputUnit, for: selectedConversionType) else {
//            outputValue = "Invalid Units"
//            return
//        }
    
//    let inputUnit = selectedConversionType.resolveUnit(from: selectedInputUnit)
//    let outputUnit = selectedConversionType.resolveUnit(from: selectedOutputUnit)
    
    var result: Double = 0.0
    
    //    switch selectedConversionType {
    //    case .length:
    //        result = Length.convert(value: input, from: inputUnit as! UnitLength, to: outputUnit as! UnitLength)
    //    case .duration:
    //        result = Duration.convert(value: input, from: inputUnit as! UnitDuration, to: outputUnit as! UnitDuration)
    //    default:
    //        result = 0.0
    //    }

    switch selectedConversionType {
    case .angle:
      result = Angle.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .duration:
        result = Duration.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .electricCharge:
      result = ElectricCharge.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    case .length:
        result = Length.convert(value: input, from: selectedInputUnit, to: selectedOutputUnit)
    default:
        result = 0.0
    }

//    if selectedConversionType == .duration {
//      if selectedInputUnit == "Hours" {
//        if selectedOutputUnit == "Minutes" {
//          result = Duration.convert(value: input, from: .hours, to: .minutes)
//        } else if selectedOutputUnit == "Seconds" {
//          result = Duration.convert(value: input, from: .hours, to: .seconds)
//        } else {
//          result = 0.0
//        }
//      } else if selectedInputUnit == "Minutes" {
//        if selectedInputUnit == "Seconds" {
//          result = Duration.convert(value: input, from: .minutes, to: .seconds)
//        } else if selectedOutputUnit == "Hours" {
//          result = Duration.convert(value: input, from: .minutes, to: .hours)
//        } else {
//          result = 0.0
//        }
//      } else {
//        result = 0.0
//      }
//    } else if selectedConversionType == .length {
//      if selectedInputUnit == "Inches" {
//        if selectedOutputUnit == "Millimeters" {
//          result = Length.convert(value: input, from: .inches, to: .millimeters)
//        } else if selectedOutputUnit == "Meters" {
//          result = Length.convert(value: input, from: .inches, to: .meters)
//        } else if selectedOutputUnit == "Angstroms" {
//          result = Length.convert(value: input, from: .inches, to: .angstroms)
//        } else if selectedOutputUnit == "Centimeters" {
//          result = Length.convert(value: input, from: .inches, to: .centimeters)
//        } else if selectedOutputUnit == "Nanometers" {
//          result = Length.convert(value: input, from: .inches, to: .nanometers)
//        } else if selectedOutputUnit == "Picometers" {
//          result = Length.convert(value: input, from: .inches, to: .picometers)
//        } else {
//          result = 0.0
//        }
//      } else if selectedInputUnit == "Millimeters" {
//        if selectedOutputUnit == "Inches" {
//          result = Length.convert(value: input, from: .millimeters, to: .inches)
//        } else {
//          result = 0.0
//        }
//      } else {
//        result = 0.0
//      }
//    }
    outputValue = String(format: "%.2f", result)
  }
}
