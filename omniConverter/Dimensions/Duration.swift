//
//  Duration.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Duration: String, CaseIterable, Identifiable {
  case hours = "Hours"
  case minutes = "Minutes"
  case seconds = "Seconds"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitDuration] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitDuration? {
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
  
  static func convert(value: Double, from: UnitDuration, to: UnitDuration) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitDuration {
  static let allUnits: [String: UnitDuration] = [
    "Hours": .hours,
    "Minutes": .minutes,
    "Seconds": .seconds
  ]
}

extension String {
  fileprivate var toUnit: UnitDuration? {
    if let v = UnitDuration.value(forKey: self) {
      if let value = v as? UnitDuration {
        return value
      }
    }
    
    return nil
  }
}
