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
  
  static var allUnitCases: [UnitElectricCurrent] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitElectricCurrent? {
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
  
  static func convert(value: Double, from: UnitElectricCurrent, to: UnitElectricCurrent) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricCurrent {
  static let allUnits: [String: UnitElectricCurrent] = [
    "Amperes": .amperes,
    "Kiloamperes": .kiloamperes,
    "Megaamperes": .megaamperes,
    "Microamperes": .microamperes,
    "Milliamperes": .milliamperes
  ]
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
