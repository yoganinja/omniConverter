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
//  case centigal = "Centigal"
//  case decigal = "Decigal"
//  case decimetersPerSecondSquared = "Decimeters per Second Squared"
//  case feetPerSecondSquared = "Feet per Second Squared"
//  case galileo = "Galileo"
//  case inchesPerSecondSquared = "Inches per Second Squared"
//  case kilometersPerSecondSquared = "Kilometers per Second Squared"
//  case knotsPerSecondSquared = "Knots per Second Squared"
//  case microgal = "Microgal"
//  case milesPerHourMinute = "Miles per Hour Minute"
//  case milesPerHourSecond = "Miles per Hour Second"
//  case milesPerSecondSquared = "Miles per Second Squared"
//  case milligal = "Milligal"
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
  
  static func convert(value: Double, from input: String, to output: String) -> Double {
    let from = self.unit(from: input)
    let to = self.unit(from: output)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
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
