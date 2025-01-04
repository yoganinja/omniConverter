//
//  Acceleration.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Acceleration: String, CaseIterable, Identifiable {
  case gravity = "Earth Gravity"
  case metersPerSecondSquared = "Meters per Second Squared"
//  case decimetersPerSecondSquared = "Decimeters per Second Squared"
//  case feetPerSecondSquared = "Feet per Second Squared"
  case galileos = "Galileos"
    case decigals = "Decigals"
    case centigals = "Centigals"
  case milligals = "Milligals"
  case microgals = "Microgals"
//  case inchesPerSecondSquared = "Inches per Second Squared"
//  case kilometersPerSecondSquared = "Kilometers per Second Squared"
//  case knotsPerSecondSquared = "Knots per Second Squared"
//  case milesPerHourMinute = "Miles per Hour Minute"
//  case milesPerHourSecond = "Miles per Hour Second"
//  case milesPerSecondSquared = "Miles per Second Squared"
//  case yardsPerSecondSquared = "Yards per Second Squared"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitAcceleration? {
    if let unit = UnitAcceleration.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitAcceleration, to: UnitAcceleration) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitAcceleration {
  static let allUnits: [String: UnitAcceleration] = {
    Acceleration.allCases.reduce(into: [String: UnitAcceleration]()) { dict, type in
      switch type {
      case .gravity:
        dict[type.rawValue] = .gravity
      case .metersPerSecondSquared:
        dict[type.rawValue] = .metersPerSecondSquared
      case .galileos:
        dict[type.rawValue] = .galileos
      case .decigals:
        dict[type.rawValue] = .decigals
      case .centigals:
        dict[type.rawValue] = .centigals
      case .milligals:
        dict[type.rawValue] = .milligals
      case .microgals:
        dict[type.rawValue] = .microgals
      }
    }
  }()
  
  static let allCases: [UnitAcceleration] =
  Acceleration.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitAcceleration? {
    if let v = UnitAcceleration.value(forKey: self) {
      if let value = v as? UnitAcceleration {
        return value
      }
    }
    
    return nil
  }
}

extension UnitAcceleration {
  static var galileos: UnitAcceleration {
    // 1 galileos = 0.01 meters/second-squared
    return UnitAcceleration(
      symbol: "Gal",
      converter: UnitConverterLinear(coefficient: 0.01))
  }

  static var decigals: UnitAcceleration {
    // 1 decigals = 0.001 meters/second-squared
    return UnitAcceleration(
      symbol: "dGal",
      converter: UnitConverterLinear(coefficient: 0.001))
  }

  static var centigals: UnitAcceleration {
    // 1 centigal = 0.0001 meters/second-squared
    return UnitAcceleration(
      symbol: "cGal",
      converter: UnitConverterLinear(coefficient: 0.0001))
  }

  static var milligals: UnitAcceleration {
    // 1 galileos = 0.00001 meters/second-squared
    return UnitAcceleration(
      symbol: "mGal",
      converter: UnitConverterLinear(coefficient: 0.00001))
  }

  static var microgals: UnitAcceleration {
    // 1 galileos = 0.00000001 meters/second-squared
    return UnitAcceleration(
      symbol: "μGal",
      converter: UnitConverterLinear(coefficient: 0.00000001))
  }
}
