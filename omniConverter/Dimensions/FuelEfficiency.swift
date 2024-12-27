//
//  FuelEfficiency.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum FuelEfficiency: String, CaseIterable, Identifiable {
  case litersPer100Kilometers = "Liters per 100 Kilometers"
  case milesPerGallon = "Miles per Gallon"
  case milesPerImperialGallon = "Miles per Imperial Gallon"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitFuelEfficiency] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitFuelEfficiency? {
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
  
  static func convert(value: Double, from: UnitFuelEfficiency, to: UnitFuelEfficiency) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitFuelEfficiency {
  static let allUnits: [String: UnitFuelEfficiency] = [
    "Liters per 100 Kilometers": .litersPer100Kilometers,
    "Miles per Gallon": .milesPerGallon,
    "Miles per Imperial Gallon": .milesPerImperialGallon
  ]
}

extension String {
  fileprivate var toUnit: UnitFuelEfficiency? {
    if let v = UnitFuelEfficiency.value(forKey: self) {
      if let value = v as? UnitFuelEfficiency {
        return value
      }
    }
    
    return nil
  }
}
