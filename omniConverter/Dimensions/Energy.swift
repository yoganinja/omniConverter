//
//  Energy.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Energy: String, CaseIterable, Identifiable {
  case btus = "British Thermal Units"
  case calories = "Calories"
  case footPounds = "Foot Pounds"
  case inchPounds = "Inch Pounds"
  case joules = "Joules"
  case kilocalories = "Kilocalories"
  case kilojoules = "Kilojoules"
  case kilowattHours = "Kilowatt Hours"
  case newtonMeters = "Newton Meters"
  
  var id: String { self.rawValue }
  var symbol: String { Energy.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitEnergy? {
    if let unit = UnitEnergy.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitEnergy, to: UnitEnergy) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitEnergy {
  static let allUnits: [String: UnitEnergy] = {
    Energy.allCases.reduce(into: [String: UnitEnergy]()) { dict, type in
      switch type {
      case .btus:
        dict[type.rawValue] = .btus
      case .calories:
        dict[type.rawValue] = .calories
      case .footPounds:
        dict[type.rawValue] = .footPounds
      case .inchPounds:
        dict[type.rawValue] = .inchPounds
      case .joules:
        dict[type.rawValue] = .joules
      case .kilocalories:
        dict[type.rawValue] = .kilocalories
      case .kilojoules:
        dict[type.rawValue] = .kilojoules
      case .kilowattHours:
        dict[type.rawValue] = .kilowattHours
      case .newtonMeters:
        dict[type.rawValue] = .newtonMeters
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

extension UnitEnergy {
  static var inchPounds: UnitEnergy {
    // 1 inchPound = 0.112981584 joules
    return UnitEnergy(
      symbol: "in-lb",
      converter: UnitConverterLinear(coefficient: 0.112981584))
  }
  
  static var footPounds: UnitEnergy {
    // 1 footPound = 1.356 joules
    return UnitEnergy(
      symbol: "ft-lb",
      converter: UnitConverterLinear(coefficient: 1.356))
  }
  
  static var btus: UnitEnergy {
    // 1 btu = 1055.056 joules
    return UnitEnergy(
      symbol: "btu",
      converter: UnitConverterLinear(coefficient: 1055.056))
  }
  
  static var newtonMeters: UnitEnergy {
    // 1 btu = 1 joules
    return UnitEnergy(
      symbol: "Nm",
      converter: UnitConverterLinear(coefficient: 1.0))
  }
}
