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
  case microgramsPerDeciliter = "Micrograms per Deciliter"
  case nanogramsPerDeciliter = "Nanograms per Deciliter"
  case picogramsPerDeciliter = "Picograms per Deciliter"
  case kilogramsPerLiter = "Kilograms per Liter"
  case hectogramsPerLiter = "Hectograms per Liter"
  case decagramsPerLiter = "Decagrams per Liter"
  case gramsPerLiter = "Grams per Liter"
  case decigramsPerLiter = "Decigrams per Liter"
  case centigramsPerLiter = "Centigrams per Liter"
  case milligramsPerLiter = "Milligrams per Liter"
  case gramsPerMilliliter = "Grams per Milliliter"
  case decigramsPerMilliliter = "Decigrams per Milliliter"
  case centigramsPerMilliliter = "Centigrams per Milliliter"
  case milligramsPerMilliliter = "Milligrams per Milliliter"
  case microgramsPerMilliliter = "Micrograms per Milliliter"
  case nanogramsPerMilliliter = "Nanograms per Milliliter"
  case picogramsPerMilliliter = "Picograms per Milliliter"
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
  
  static func convert(value: Double, from input: String, to output: String) -> Double? {
    guard
      let from = self.unit(from: input),
      let to = self.unit(from: output)
    else {
      return nil
    }
    
    let result = self.convert(value: value, from: from, to: to)
    
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
      case .microgramsPerDeciliter:
        dict[type.rawValue] = .microgramsPerDeciliter
      case .nanogramsPerDeciliter:
        dict[type.rawValue] = .nanogramsPerDeciliter
      case .picogramsPerDeciliter:
        dict[type.rawValue] = .picogramsPerDeciliter
      case .gramsPerLiter:
        dict[type.rawValue] = .gramsPerLiter
      case .decigramsPerMilliliter:
        dict[type.rawValue] = .decigramsPerMilliliter
      case .centigramsPerMilliliter:
        dict[type.rawValue] = .centigramsPerMilliliter
      case .milligramsPerMilliliter:
        dict[type.rawValue] = .milligramsPerMilliliter
      case .kilogramsPerLiter:
        dict[type.rawValue] = .kilogramsPerLiter
      case .hectogramsPerLiter:
        dict[type.rawValue] = .hectogramsPerLiter
      case .decagramsPerLiter:
        dict[type.rawValue] = .decagramsPerLiter
      case .decigramsPerLiter:
        dict[type.rawValue] = .decigramsPerLiter
      case .centigramsPerLiter:
        dict[type.rawValue] = .centigramsPerLiter
      case .milligramsPerLiter:
        dict[type.rawValue] = .milligramsPerLiter
      case .microgramsPerMilliliter:
        dict[type.rawValue] = .microgramsPerMilliliter
      case .nanogramsPerMilliliter:
        dict[type.rawValue] = .nanogramsPerMilliliter
      case .picogramsPerMilliliter:
        dict[type.rawValue] = .picogramsPerMilliliter
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
//  static var milligramsPerDeciliterx: UnitConcentrationMass {
//    // 100000 milligramsPerDeciliter = 1000 gramsPerLiter
//    return UnitConcentrationMass(
//      symbol: "mg/dL",
//      converter: UnitConverterLinear(coefficient: 0.01))
//  }
  
  static var microgramsPerDeciliter: UnitConcentrationMass {
    // 1000000 microgramsPerDeciliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "μg/dL",
      converter: UnitConverterLinear(coefficient: 0.001))
  }
  
  static var nanogramsPerDeciliter: UnitConcentrationMass {
    // 10000000 nanogramsPerDeciliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "ng/dL",
      converter: UnitConverterLinear(coefficient: 0.0001))
  }
  
  static var picogramsPerDeciliter: UnitConcentrationMass {
    // 100000000 picogramsPerDeciliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "pg/dL",
      converter: UnitConverterLinear(coefficient: 0.00001))
  }
  
  static var kilogramsPerLiter: UnitConcentrationMass {
    // 1 kilogramPerLiter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "kg/L",
      converter: UnitConverterLinear(coefficient: 1000))
  }
  
  static var hectogramsPerLiter: UnitConcentrationMass {
    // 1 hectogramPerLiter = 100 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "hg/L",
      converter: UnitConverterLinear(coefficient: 100))
  }
  
  static var decagramsPerLiter: UnitConcentrationMass {
    // 1 decagramPerLiter = 10 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "dag/L",
      converter: UnitConverterLinear(coefficient: 10))
  }
  
  static var decigramsPerLiter: UnitConcentrationMass {
    // 1 decigramPerLiter = 1/10 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "dg/L",
      converter: UnitConverterLinear(coefficient: 0.1))
  }
  
  static var centigramsPerLiter: UnitConcentrationMass {
    // 1 centigramPerLiter = 1/100 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "cg/L",
      converter: UnitConverterLinear(coefficient: 0.01))
  }
  
  static var milligramsPerLiter: UnitConcentrationMass {
    // 1 milligramPerLiter = 1/1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "mg/L",
      converter: UnitConverterLinear(coefficient: 0.001))
  }
  
  static var gramsPerMilliliter: UnitConcentrationMass {
    // 1 gramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "g/mL",
      converter: UnitConverterLinear(coefficient: 1000))
  }
  
  static var decigramsPerMilliliter: UnitConcentrationMass {
    // 10 decigramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "dg/mL",
      converter: UnitConverterLinear(coefficient: 10000))
  }
  
  static var centigramsPerMilliliter: UnitConcentrationMass {
    // 100 centigramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "cg/mL",
      converter: UnitConverterLinear(coefficient: 100000))
  }
  
  static var milligramsPerMilliliter: UnitConcentrationMass {
    // 1000 milligramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "mg/mL",
      converter: UnitConverterLinear(coefficient: 1000000))
  }
  
  static var microgramsPerMilliliter: UnitConcentrationMass {
    // 10000 microgramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "μg/mL",
      converter: UnitConverterLinear(coefficient: 10000000))
  }
  
  static var nanogramsPerMilliliter: UnitConcentrationMass {
    // 100000 nanogramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "ng/mL",
      converter: UnitConverterLinear(coefficient: 100000000))
  }
  
  static var picogramsPerMilliliter: UnitConcentrationMass {
    // 1000000 picogramPerMilliliter = 1000 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "pg/mL",
      converter: UnitConverterLinear(coefficient: 1000000000))
  }
  
  static var ouncesPerFluidOunce: UnitConcentrationMass {
    // 1 ouncesPerFluidOunce = 958.61229 gramsPerLiter
    return UnitConcentrationMass(
      symbol: "oz/fl oz",
      converter: UnitConverterLinear(coefficient: 958.61229))
  }
}
