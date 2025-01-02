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
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitPressure? {
    if let unit = UnitPressure.allUnits[name] {
      return unit
    } else {
      return nil
    }
  }
  
  static func convert(value: Double, from input: String, to output: String) -> Double {
    let from = self.unit(from: input)
    let to = self.unit(from: output)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitPressure, to: UnitPressure) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitPressure {
  static let allUnits: [String: UnitPressure] = {
    Pressure.allCases.reduce(into: [String: UnitPressure]()) { dict, type in
      switch type {
      case .bars:
        dict[type.rawValue] = .bars
      case .gigapascals:
        dict[type.rawValue] = .gigapascals
      case .hectopascals:
        dict[type.rawValue] = .hectopascals
      case .inchesOfMercury:
        dict[type.rawValue] = .inchesOfMercury
      case .kilopascals:
        dict[type.rawValue] = .kilopascals
      case .megapascals:
        dict[type.rawValue] = .megapascals
      case .millibars:
        dict[type.rawValue] = .millibars
      case .millimetersOfMercury:
        dict[type.rawValue] = .millimetersOfMercury
      case .newtonsPerMetersSquared:
        dict[type.rawValue] = .newtonsPerMetersSquared
      case .poundsForcePerSquareInch:
        dict[type.rawValue] = .poundsForcePerSquareInch
      }
    }
  }()
  
  static let allCases: [UnitPressure] =
  Pressure.allCases.compactMap { $0.id.toUnit }
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
