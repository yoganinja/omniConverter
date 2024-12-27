//
//  Frequency.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Frequency: String, CaseIterable, Identifiable {
  case gigahertz = "Gigahertz"
  case hertz = "Hertz"
  case kilohertz = "Kilohertz"
  case megahertz = "Megahertz"
  case microhertz = "Microhertz"
  case millihertz = "Millihertz"
  case nanohertz = "Nanohertz"
  case terahertz = "Terahertz"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitFrequency] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitFrequency? {
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
  
  static func convert(value: Double, from: UnitFrequency, to: UnitFrequency) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitFrequency {
  static let allUnits: [String: UnitFrequency] = [
    "Gigahertz": .gigahertz,
    "Hertz": .hertz,
    "Kilohertz": .kilohertz,
    "Megahertz": .megahertz,
    "Microhertz": .microhertz,
    "Millihertz": .millihertz,
    "Nanohertz": .nanohertz,
    "Terahertz": .terahertz
  ]
}

extension String {
  fileprivate var toUnit: UnitFrequency? {
    if let v = UnitFrequency.value(forKey: self) {
      if let value = v as? UnitFrequency {
        return value
      }
    }
    
    return nil
  }
}
