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

  static var allUnitCases: [UnitMass] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitMass? {
    for item in allCases {
      if String(describing: item).stripSpaces.lowercased() == stringName.stripSpaces.lowercased() {
        let itemIndex = allCases.firstIndex(of: item)
        let lookupItem = allUnitCases[itemIndex!]
        return lookupItem
      }
    }
    
    return nil
  }
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = self.name(from: stringFrom)
    let to = self.name(from: stringTo)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitMass, to: UnitMass) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
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

extension UnitMass {
  static let allUnits: [String: UnitMass] = [
    "Carats": .carats,
    "Centigrams": .centigrams,
    "Decigrams": .decigrams,
    "Grains": .grains,
    "Grams": .grams,
    "Kilograms": .kilograms,
    "Metric Tons": .metricTons,
    "Micrograms": .micrograms,
    "Milligrams": .milligrams,
    "Nanograms": .nanograms,
    "Ounces": .ounces,
    "Ounces Troy": .ouncesTroy,
    "Picograms": .picograms,
    "Pounds": .pounds,
    "Short Tons": .shortTons,
    "Slugs": .slugs,
    "Stones": .stones
  ]
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
