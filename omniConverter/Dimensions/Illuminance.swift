//
//  Illuminance.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Illuminance: String, CaseIterable, Identifiable {
  case lux = "Lux"
//  case nox = "Nox"
//  case phot = "Phot"
//  case kilolux = "Kilolux"
//  case lumenPerCentimeter = "Lumen per Centimeter"
//  case lumenPerMeter = "Lumen per Meter"
//  case lumenPerFoot = "Lumen per Foot"
//  case lumenPerInch = "Lumen per Inch"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitIlluminance] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitIlluminance? {
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
  
  static func convert(value: Double, from: UnitIlluminance, to: UnitIlluminance) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

//case nox = "Nox"
//case phot = "Phot"
//case kilolux = "Kilolux"
//case lumenPerCentimeter = "Lumen per Centimeter"
//case lumenPerMeter = "Lumen per Meter"
//case lumenPerFoot = "Lumen per Foot"
//case lumenPerInch = "Lumen per Inch"
extension UnitIlluminance {
  static let allUnits: [String: UnitIlluminance] = [
    "Lux": .lux
  ]
}

extension String {
  fileprivate var toUnit: UnitIlluminance? {
    if let v = UnitIlluminance.value(forKey: self) {
      if let value = v as? UnitIlluminance {
        return value
      }
    }
    
    return nil
  }
}
