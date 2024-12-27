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
  
  static var allUnitCases: [UnitElectricCharge] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitElectricCharge? {
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
  
  static func convert(value: Double, from: UnitElectricCharge, to: UnitElectricCharge) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitElectricCharge {
  static let allUnits: [String: UnitElectricCharge] = [
    "Ampere Hours": .ampereHours,
    "Coulombs": .coulombs,
    "Kiloampere Hours": .kiloampereHours,
    "Megaampere Hours": .megaampereHours,
    "Microampere Hours": .microampereHours,
    "Milliampere Hours": .milliampereHours
  ]
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
