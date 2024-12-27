//
//  Speed.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Speed: String, CaseIterable, Identifiable {
  case kilometersPerHour = "Kilometers per Hour"
  case knots = "Knots"
  case metersPerSecond = "Meters per Second"
  case milesPerHour = "Miles per Hour"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitSpeed] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitSpeed? {
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
  
  static func convert(value: Double, from: UnitSpeed, to: UnitSpeed) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitSpeed {
  static let allUnits: [String: UnitSpeed] = [
    "Kilometers per Hour": .kilometersPerHour,
    "Knots": .knots,
    "Meters per Second": .metersPerSecond,
    "Miles per Hour": .milesPerHour
  ]
}

extension String {
  fileprivate var toUnit: UnitSpeed? {
    if let v = UnitSpeed.value(forKey: self) {
      if let value = v as? UnitSpeed {
        return value
      }
    }
    
    return nil
  }
}
