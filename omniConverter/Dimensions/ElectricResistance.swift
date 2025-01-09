//
//  ElectricResistance.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum ElectricResistance: String, CaseIterable, Identifiable {
  case kiloohms = "Kiloohms"
  case megaohms = "Megaohms"
  case microohms = "Microohms"
  case milliohms = "Milliohms"
  case ohms = "Ohms"
  
  var id: String { self.rawValue }
  var symbol: String { ElectricResistance.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitElectricResistance? {
    if let unit = UnitElectricResistance.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitElectricResistance, to: UnitElectricResistance) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricResistance {
  static let allUnits: [String: UnitElectricResistance] = {
    ElectricResistance.allCases.reduce(into: [String: UnitElectricResistance]()) { dict, type in
      switch type {
      case .kiloohms:
        dict[type.rawValue] = .kiloohms
      case .megaohms:
        dict[type.rawValue] = .megaohms
      case .microohms:
        dict[type.rawValue] = .microohms
      case .milliohms:
        dict[type.rawValue] = .milliohms
      case .ohms:
        dict[type.rawValue] = .ohms
      }
    }
  }()
  
  static let allCases: [UnitElectricResistance] =
  ElectricResistance.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitElectricResistance? {
    if let v = UnitElectricResistance.value(forKey: self) {
      if let value = v as? UnitElectricResistance {
        return value
      }
    }
    
    return nil
  }
}
