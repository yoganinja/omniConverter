//
//  ElectricPotentialDifference.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum ElectricPotentialDifference: String, CaseIterable, Identifiable {
  case kilovolts = "Kilovolts"
  case megavolts = "Megavolts"
  case microvolts = "Microvolts"
  case millivolts = "Millivolts"
  case volts = "Volts"
  
  var id: String { self.rawValue }
  var symbol: String { ElectricPotentialDifference.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitElectricPotentialDifference? {
    if let unit = UnitElectricPotentialDifference.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitElectricPotentialDifference, to: UnitElectricPotentialDifference) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricPotentialDifference {
  static let allUnits: [String: UnitElectricPotentialDifference] = {
    ElectricPotentialDifference.allCases.reduce(into: [String: UnitElectricPotentialDifference]()) { dict, type in
      switch type {
      case .kilovolts:
        dict[type.rawValue] = .kilovolts
      case .megavolts:
        dict[type.rawValue] = .megavolts
      case .microvolts:
        dict[type.rawValue] = .microvolts
      case .millivolts:
        dict[type.rawValue] = .millivolts
      case .volts:
        dict[type.rawValue] = .volts
      }
    }
  }()
  
  static let allCases: [UnitElectricPotentialDifference] =
  ElectricPotentialDifference.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitElectricPotentialDifference? {
    if let v = UnitElectricPotentialDifference.value(forKey: self) {
      if let value = v as? UnitElectricPotentialDifference {
        return value
      }
    }
    
    return nil
  }
}


extension UnitElectricPotentialDifference: UnitProduct {
  static func defaultUnitMapping() -> (UnitElectricResistance, UnitElectricCurrent, UnitElectricPotentialDifference) {
    return (.ohms, .amperes, .volts)
  }
}
