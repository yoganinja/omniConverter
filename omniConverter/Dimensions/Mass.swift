//
//  Mass.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Mass: String, CaseIterable, Identifiable {
  case carats = "Carats"
  case centigrams = "Centigrams"
  case decigrams = "Decigrams"
  case grains = "Grains"
  case grams = "Grams"
  case kilograms = "Kilograms"
  case metricTons = "Metric Tons"
  case micrograms = "Micrograms"
  case milligrams = "Milligrams"
  case nanograms = "Nanograms"
  case ounces = "Ounces"
  case ouncesTroy = "Ounces Troy"
  case picograms = "Picograms"
  case pounds = "Pounds"
  case shortTons = "Short Tons"
  case slugs = "Slugs"
  case stones = "Stones"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitMass? {
    if let unit = UnitMass.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitMass, to: UnitMass) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitMass {
  static let allUnits: [String: UnitMass] = {
    Mass.allCases.reduce(into: [String: UnitMass]()) { dict, type in
      switch type {
      case .carats:
        dict[type.rawValue] = .carats
      case .centigrams:
        dict[type.rawValue] = .centigrams
      case .decigrams:
        dict[type.rawValue] = .decigrams
      case .grains:
        dict[type.rawValue] = .grains
      case .grams:
        dict[type.rawValue] = .grams
      case .kilograms:
        dict[type.rawValue] = .kilograms
      case .metricTons:
        dict[type.rawValue] = .metricTons
      case .micrograms:
        dict[type.rawValue] = .micrograms
      case .milligrams:
        dict[type.rawValue] = .milligrams
      case .nanograms:
        dict[type.rawValue] = .nanograms
      case .ounces:
        dict[type.rawValue] = .ounces
      case .ouncesTroy:
        dict[type.rawValue] = .ouncesTroy
      case .picograms:
        dict[type.rawValue] = .picograms
      case .pounds:
        dict[type.rawValue] = .pounds
      case .shortTons:
        dict[type.rawValue] = .shortTons
      case .slugs:
        dict[type.rawValue] = .slugs
      case .stones:
        dict[type.rawValue] = .stones
      }
    }
  }()
  
  static let allCases: [UnitMass] =
  Mass.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitMass? {
    if let v = UnitMass.value(forKey: self) {
      if let value = v as? UnitMass {
        return value
      }
    }
    
    return nil
  }
}



extension UnitMass {
  static var grains: UnitMass {
    // 1 grain = 6.47989e-5 kilograms
    return UnitMass(
      symbol: "gr",
      converter: UnitConverterLinear(coefficient: 6.47989e-5))
  }
}

/// UnitMass = UnitDensity * UnitVolume
/// ⇔ UnitDensity = UnitMass / UnitVolume
extension UnitMass: UnitProduct {
  typealias Factor1 = UnitDensity
  typealias Factor2 = UnitVolume
  typealias Product = UnitMass
  
  static func defaultUnitMapping() -> (UnitDensity, UnitVolume, UnitMass) {
    return (.ouncesPerFluidOunce, .fluidOunces, .ounces)
  }
}

extension UnitDensity: UnitProduct {
  typealias Factor1 = UnitMass
  typealias Factor2 = UnitVolume
  typealias Product = UnitDensity
  
  static func defaultUnitMapping() -> (UnitMass, UnitVolume, UnitDensity) {
    return (.ounces, .fluidOunces, .ouncesPerFluidOunce)
  }
}

extension UnitVolume: UnitProduct {
  typealias Factor1 = UnitDensity
  typealias Factor2 = UnitMass
  typealias Product = UnitVolume
  
  static func defaultUnitMapping() -> (UnitDensity, UnitMass, UnitVolume) {
    return (.ouncesPerFluidOunce, .ounces, .fluidOunces)
  }
}
