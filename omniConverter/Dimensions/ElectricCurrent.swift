//
//  ElectricCurrent.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum ElectricCurrent: String, CaseIterable, Identifiable {
  case amperes = "Amperes"
  case kiloamperes = "Kiloamperes"
  case megaamperes = "Megaamperes"
  case microamperes = "Microamperes"
  case milliamperes = "Milliamperes"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitElectricCurrent? {
    if let unit = UnitElectricCurrent.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitElectricCurrent, to: UnitElectricCurrent) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricCurrent {
  static let allUnits: [String: UnitElectricCurrent] = {
    ElectricCurrent.allCases.reduce(into: [String: UnitElectricCurrent]()) { dict, type in
      switch type {
      case .amperes:
        dict[type.rawValue] = .amperes
      case .kiloamperes:
        dict[type.rawValue] = .kiloamperes
      case .megaamperes:
        dict[type.rawValue] = .megaamperes
      case .microamperes:
        dict[type.rawValue] = .microamperes
      case .milliamperes:
        dict[type.rawValue] = .milliamperes
      }
    }
  }()
  
  static let allCases: [UnitElectricCurrent] =
  ElectricCurrent.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitElectricCurrent? {
    if let v = UnitElectricCurrent.value(forKey: self) {
      if let value = v as? UnitElectricCurrent {
        return value
      }
    }
    
    return nil
  }
}
