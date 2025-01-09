//
//  FuelEfficiency.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum FuelEfficiency: String, CaseIterable, Identifiable {
  case litersPer100Kilometers = "Liters per 100 Kilometers"
  case milesPerGallon = "Miles per Gallon"
  case milesPerImperialGallon = "Miles per Imperial Gallon"
  
  var id: String { self.rawValue }
  var symbol: String { FuelEfficiency.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitFuelEfficiency? {
    if let unit = UnitFuelEfficiency.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitFuelEfficiency, to: UnitFuelEfficiency) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitFuelEfficiency {
  static let allUnits: [String: UnitFuelEfficiency] = {
    FuelEfficiency.allCases.reduce(into: [String: UnitFuelEfficiency]()) { dict, type in
      switch type {
      case .litersPer100Kilometers:
        dict[type.rawValue] = .litersPer100Kilometers
      case .milesPerGallon:
        dict[type.rawValue] = .milesPerGallon
      case .milesPerImperialGallon:
        dict[type.rawValue] = .milesPerImperialGallon
      }
    }
  }()
  
  static let allCases: [UnitFuelEfficiency] =
  FuelEfficiency.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitFuelEfficiency? {
    if let v = UnitFuelEfficiency.value(forKey: self) {
      if let value = v as? UnitFuelEfficiency {
        return value
      }
    }
    
    return nil
  }
}
