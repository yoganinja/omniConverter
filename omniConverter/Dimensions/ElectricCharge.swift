//
//  ElectricCharge.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum ElectricCharge: String, CaseIterable, Identifiable {
  case ampereHours = "Ampere Hours"
  case coulombs = "Coulombs"
  case kiloampereHours = "Kiloampere Hours"
  case megaampereHours = "Megaampere Hours"
  case microampereHours = "Microampere Hours"
  case milliampereHours = "Milliampere Hours"
  
  var id: String { self.rawValue }
  var symbol: String { ElectricCharge.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitElectricCharge? {
    if let unit = UnitElectricCharge.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitElectricCharge, to: UnitElectricCharge) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricCharge {
  static let allUnits: [String: UnitElectricCharge] = {
    ElectricCharge.allCases.reduce(into: [String: UnitElectricCharge]()) { dict, type in
      switch type {
      case .ampereHours:
        dict[type.rawValue] = .ampereHours
      case .coulombs:
        dict[type.rawValue] = .coulombs
      case .kiloampereHours:
        dict[type.rawValue] = .kiloampereHours
      case .megaampereHours:
        dict[type.rawValue] = .megaampereHours
      case .microampereHours:
        dict[type.rawValue] = .microampereHours
      case .milliampereHours:
        dict[type.rawValue] = .milliampereHours
      }
    }
  }()
  
  static let allCases: [UnitElectricCharge] =
  ElectricCharge.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitElectricCharge? {
    if let v = UnitElectricCharge.value(forKey: self) {
      if let value = v as? UnitElectricCharge {
        return value
      }
    }
    
    return nil
  }
}
