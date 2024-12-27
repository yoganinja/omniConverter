//
//  Energy.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Energy: String, CaseIterable, Identifiable {
  case calories = "Calories"
  case joules = "Joules"
  case kilocalories = "Kilocalories"
  case kilojoules = "Kilojoules"
  case kilowattHours = "Kilowatt Hours"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitEnergy] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitEnergy? {
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
  
  static func convert(value: Double, from: UnitEnergy, to: UnitEnergy) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitEnergy {
  static let allUnits: [String: UnitEnergy] = [
    "Calories": .calories,
    "Joules": .joules,
    "Kilocalories": .kilocalories,
    "Kilojoules": .kilojoules,
    "Kilowatt Hours": .kilowattHours
  ]
}

extension String {
  fileprivate var toUnit: UnitEnergy? {
    if let v = UnitEnergy.value(forKey: self) {
      if let value = v as? UnitEnergy {
        return value
      }
    }
    
    return nil
  }
}
