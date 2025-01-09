//
//  Power.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Power: String, CaseIterable, Identifiable {
  case femtowatts = "Femtowatts"
  case gigawatts = "Gigawatts"
  case horsepower = "Horsepower"
  case kilowatts = "Kilowatts"
  case megawatts = "Megawatts"
  case microwatts = "Microwatts"
  case milliwatts = "Milliwatts"
  case nanowatts = "Nanowatts"
  case picowatts = "Picowatts"
  case terawatts = "Terawatts"
  case watts = "Watts"
  
  var id: String { self.rawValue }
  var symbol: String { Power.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitPower? {
    if let unit = UnitPower.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitPower, to: UnitPower) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitPower {
  static let allUnits: [String: UnitPower] = {
    Power.allCases.reduce(into: [String: UnitPower]()) { dict, type in
      switch type {
      case .femtowatts:
        dict[type.rawValue] = .femtowatts
      case .gigawatts:
        dict[type.rawValue] = .gigawatts
      case .horsepower:
        dict[type.rawValue] = .horsepower
      case .kilowatts:
        dict[type.rawValue] = .kilowatts
      case .megawatts:
        dict[type.rawValue] = .megawatts
      case .microwatts:
        dict[type.rawValue] = .microwatts
      case .milliwatts:
        dict[type.rawValue] = .milliwatts
      case .nanowatts:
        dict[type.rawValue] = .nanowatts
      case .picowatts:
        dict[type.rawValue] = .picowatts
      case .terawatts:
        dict[type.rawValue] = .terawatts
      case .watts:
        dict[type.rawValue] = .watts
      }
    }
  }()
  
  static let allCases: [UnitPower] =
  Power.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitPower? {
    if let v = UnitPower.value(forKey: self) {
      if let value = v as? UnitPower {
        return value
      }
    }
    
    return nil
  }
}
