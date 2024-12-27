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

  /// Array of Unit representations of all enum cases
  static var allUnitCases: [UnitAcceleration] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  /// Unit representation of a case
  var toUnit: UnitAcceleration? {
    get {
      if let _ = Acceleration.allCases.firstIndex(of: self) {
        return self.rawValue.toUnit
      }
      
      return nil
    }
  }
  
  /// String representation of the enum case
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = stringFrom.toUnit
    let to = stringTo.toUnit
    //        let to = self.unit(from: stringTo)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitAcceleration, to: UnitAcceleration) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitAcceleration {
  static let allUnits: [String: UnitAcceleration] = [
    "Earth Gravity": .gravity,
    "Meters per Second Squared": .metersPerSecondSquared,
//    "Centigal": .centigal,
//    "Decigal": .decigal,
//    "Decimeters per Second Squared": .decimetersPerSecondSquared,
//    "Feet per Second Squared": .feetPerSecondSquared,
//    "Galileo": .galileo,
//    "Inches per Second Squared": .inchesPerSecondSquared,
//    "Kilometers per Second Squared": .kilometersPerSecondSquared,
//    "Knots per Second Squared": .knotsPerSecondSquared,
//    "Microgal": .microgal,
//    "Miles per Hour Minute": .milesPerHourMinute,
//    "Miles per Hour Second": .milesPerHourSecond,
//    "Miles per Second Squared": .milesPerSecondSquared,
//    "Milligal": .milligal,
//    "Yards per Second Squared": .yardsPerSecondSquared
  ]
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
