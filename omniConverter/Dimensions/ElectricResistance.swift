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
  
  static var allUnitCases: [UnitElectricResistance] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitElectricResistance? {
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
  
  static func convert(value: Double, from: UnitElectricResistance, to: UnitElectricResistance) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricResistance {
  static let allUnits: [String: UnitElectricResistance] = [
    "Kiloohms": .kiloohms,
    "Megaohms": .megaohms,
    "Microohms": .microohms,
    "Milliohms": .milliohms,
    "Ohms": .ohms
  ]
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
