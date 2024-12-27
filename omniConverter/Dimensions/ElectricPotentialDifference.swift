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
  
  static var allUnitCases: [UnitElectricPotentialDifference] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitElectricPotentialDifference? {
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
  
  static func convert(value: Double, from: UnitElectricPotentialDifference, to: UnitElectricPotentialDifference) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricPotentialDifference: UnitProduct {
  static func defaultUnitMapping() -> (UnitElectricResistance, UnitElectricCurrent, UnitElectricPotentialDifference) {
    return (.ohms, .amperes, .volts)
  }
}

extension UnitElectricPotentialDifference {
  static let allUnits: [String: UnitElectricPotentialDifference] = [
    "Kilovolts": .kilovolts,
    "Megavolts": .megavolts,
    "Microvolts": .microvolts,
    "Millivolts": .millivolts,
    "Volts": .volts
  ]
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
