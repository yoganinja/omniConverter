//
//  Dispersion.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Dispersion: String, CaseIterable, Identifiable {
  case partsPerMillion = "Parts per Million"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitDispersion] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitDispersion? {
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
  
  static func convert(value: Double, from: UnitDispersion, to: UnitDispersion) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitDispersion {
  static let allUnits: [String: UnitDispersion] = [
    "Parts per Million": .partsPerMillion
  ]
}

extension String {
  fileprivate var toUnit: UnitDispersion? {
    if let v = UnitDispersion.value(forKey: self) {
      if let value = v as? UnitDispersion {
        return value
      }
    }
    
    return nil
  }
}
