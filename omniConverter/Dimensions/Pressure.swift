//
//  Pressure.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Pressure: String, CaseIterable, Identifiable {
  case bars = "Bars"
  case gigapascals = "Gigapascals"
  case hectopascals = "Hectopascals"
  case inchesOfMercury = "Inches of Mercury"
  case kilopascals = "Kilopascals"
  case megapascals = "Megapascals"
  case millibars = "Millibars"
  case millimetersOfMercury = "Millimeters of Mercury"
  case newtonsPerMetersSquared = "Newtons per Meters Squared"
  case poundsForcePerSquareInch = "Pounds Force per Square Inch"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitPressure] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitPressure? {
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
  
  static func convert(value: Double, from: UnitPressure, to: UnitPressure) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitPressure {
  static let allUnits: [String: UnitPressure] = [
    "Bars": .bars,
    "Gigapascals": .gigapascals,
    "Hectopascals": .hectopascals,
    "Inches of Mercury": .inchesOfMercury,
    "Kilopascals": .kilopascals,
    "Megapascals": .megapascals,
    "Millibars": .millibars,
    "Millimeters of Mercury": .millimetersOfMercury,
    "Newtons per Meters Squared": .newtonsPerMetersSquared,
    "Pounds Force per Square Inch": .poundsForcePerSquareInch
  ]
}

extension String {
  fileprivate var toUnit: UnitPressure? {
    if let v = UnitPressure.value(forKey: self) {
      if let value = v as? UnitPressure {
        return value
      }
    }
    
    return nil
  }
}

extension String {
  /// Usage:
  /// let speedUnit = "metersPerSecond".toUnit(of: UnitSpeed.self)
  /// let lengthUnit = "meters".toUnit(of: UnitLength.self)
  /// let pressureUnit = "bars".toUnit(of: UnitPressure.self)
  /// print(speedUnit) // Optional(m/s)
  /// print(lengthUnit) // Optional(m)
  /// print(pressureUnit) // Optional(bar)

  func toUnit<T: Dimension>(of type: T.Type) -> T? {
    if let unit = T.value(forKey: self) as? T {
      return unit
    }
    return nil
  }
}
