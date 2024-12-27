//
//  Power.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Power: String, CaseIterable, Identifiable {
  case femtowatts = "Femtowatts"
  case gigawatts = "Gigawatts"
  case horsepower = "Horsepower"
  case kilowatts = "Kilowatts"
  case megawatts = "Megawatts"
  case microwatts = "Microwatts"
  case milliwatts = "Milliwatts"
  case nanowatts = "Nanowatts"
  case picowatts = "Picowatts"
  case terawatts = "Terawatts"
  case watts = "Watts"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitPower] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitPower? {
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
  
  static func convert(value: Double, from: UnitPower, to: UnitPower) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitPower {
  static let allUnits: [String: UnitPower] = [
    "Femtowatts": .femtowatts,
    "Gigawatts": .gigawatts,
    "Horsepower": .horsepower,
    "Kilowatts": .kilowatts,
    "Megawatts": .megawatts,
    "Microwatts": .microwatts,
    "Milliwatts": .milliwatts,
    "Nanowatts": .nanowatts,
    "Picowatts": .picowatts,
    "Terawatts": .terawatts,
    "Watts": .watts
  ]
}

extension String {
  fileprivate var toUnit: UnitPower? {
    if let v = UnitPower.value(forKey: self) {
      if let value = v as? UnitPower {
        return value
      }
    }
    
    return nil
  }
}
