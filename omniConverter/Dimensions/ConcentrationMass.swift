//
//  ConcentrationMass.swift
//  omniConverter
//
//  Created by John Florian on 1/2/25.
//

import Foundation

enum ConcentrationMass: String, CaseIterable, Identifiable {
//  case millimolesPerLiter = "Millimoles per Liter"
  case milligramsPerDeciliter = "Milligrams per Deciliter"
  case gramsPerLiter = "Grams per Liter"
  case gramsPerMilliliter = "Grams per Milliliter"
  case ouncesPerFluidOunce = "Ounces per Fluid Ounce"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitConcentrationMass? {
    if let unit = UnitConcentrationMass.allUnits[name] {
      return unit
    } else {
      return nil
    }
  }
  
  static func convert(value: Double, from input: String, to output: String) -> Double {
    let from = self.unit(from: input)
    let to = self.unit(from: output)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitConcentrationMass, to: UnitConcentrationMass) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitConcentrationMass {
  static let allUnits: [String: UnitConcentrationMass] = {
    ConcentrationMass.allCases.reduce(into: [String: UnitConcentrationMass]()) { dict, type in
      switch type {
      case .gramsPerMilliliter:
        dict[type.rawValue] = .gramsPerMilliliter
      case .ouncesPerFluidOunce:
        dict[type.rawValue] = .ouncesPerFluidOunce
//      case .millimolesPerLiter:
//        dict[type.rawValue] = .millimolesPerLiter(withGramsPerMole: <#T##Double#>)
      case .milligramsPerDeciliter:
        dict[type.rawValue] = .milligramsPerDeciliter
      case .gramsPerLiter:
        dict[type.rawValue] = .gramsPerLiter
      }
    }
  }()
  
  static let allCases: [UnitConcentrationMass] =
  ConcentrationMass.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitConcentrationMass? {
    if let v = UnitConcentrationMass.value(forKey: self) {
      if let value = v as? UnitConcentrationMass {
        return value
      }
    }
    
    return nil
  }
}

extension UnitConcentrationMass {
  static var gramsPerMilliliter: UnitConcentrationMass {
    // 1 gramsPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "g/mL",
      converter: UnitConverterLinear(coefficient: 1000))
  }
  
  static var ouncesPerFluidOunce: UnitConcentrationMass {
    // 1 ouncesPerFluidOunce = 958.61229 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "oz/fl oz",
      converter: UnitConverterLinear(coefficient: 958.61229))
  }
}
