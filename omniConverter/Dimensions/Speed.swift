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
  var symbol: String { Speed.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitSpeed? {
    if let unit = UnitSpeed.allUnits[name] {
      return unit
    } else {
      return nil
    }
  }
  
  static func convert(value: Double, from input: String, to output: String) -> Double? {
    guard
      let from = self.unit(from: input),
      let to = self.unit(from: output)
    else {
      return nil
    }
    
    let result = self.convert(value: value, from: from, to: to)
    
    return result
  }
  
  static func convert(value: Double, from: UnitSpeed, to: UnitSpeed) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitSpeed {
  static let allUnits: [String: UnitSpeed] = {
    Speed.allCases.reduce(into: [String: UnitSpeed]()) { dict, type in
      switch type {
      case .kilometersPerHour:
        dict[type.rawValue] = .kilometersPerHour
      case .knots:
        dict[type.rawValue] = .knots
      case .metersPerSecond:
        dict[type.rawValue] = .metersPerSecond
      case .milesPerHour:
        dict[type.rawValue] = .milesPerHour
      }
    }
  }()
  
  static let allCases: [UnitSpeed] =
  Speed.allCases.compactMap { $0.id.toUnit }
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
