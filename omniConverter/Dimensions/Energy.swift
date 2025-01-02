//
//  Energy.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Energy: String, CaseIterable, Identifiable {
  case calories = "Calories"
  case joules = "Joules"
  case kilocalories = "Kilocalories"
  case kilojoules = "Kilojoules"
  case kilowattHours = "Kilowatt Hours"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitEnergy? {
    if let unit = UnitEnergy.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitEnergy, to: UnitEnergy) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitEnergy {
  static let allUnits: [String: UnitEnergy] = {
    Energy.allCases.reduce(into: [String: UnitEnergy]()) { dict, type in
      switch type {
      case .calories:
        dict[type.rawValue] = .calories
      case .joules:
        dict[type.rawValue] = .joules
      case .kilocalories:
        dict[type.rawValue] = .kilocalories
      case .kilojoules:
        dict[type.rawValue] = .kilojoules
      case .kilowattHours:
        dict[type.rawValue] = .kilowattHours
      }
    }
  }()
  
  static let allCases: [UnitEnergy] =
  Energy.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitEnergy? {
    if let v = UnitEnergy.value(forKey: self) {
      if let value = v as? UnitEnergy {
        return value
      }
    }
    
    return nil
  }
}
