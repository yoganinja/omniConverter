//
//  Length.swift
//  omniConverter
//
//  Created by John Florian on 7/11/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Length: String, CaseIterable, Identifiable {
  case angstroms = "Angstroms"
  case astronomicalUnits = "Astronomical Units"
  case centimeters = "Centimeters"
  case decameters = "Decameters"
  case decimeters = "Decimeters"
  case fathoms = "Fathoms"
  case feet = "Feet"
  case furlongs = "Furlongs"
  case hectometers = "Hectometers"
  case inches = "Inches"
  case kilometers = "Kilometers"
  case leagues = "Leagues"
  case lightyears = "Lightyears"
  case megameters = "Megameters"
  case meters = "Meters"
  case micrometers = "Micrometers"
  case miles = "Miles"
  case millimeters = "Millimeters"
  case nanometers = "Nanometers"
  case nauticalLeagues = "Nautical Leagues"
  case nauticalMiles = "Nautical Miles"
  case parsecs = "Parsecs"
  case picometers = "Picometers"
  case scandinavianMiles = "Scandinavian Miles"
  case yards = "Yards"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitLength? {
    if let unit = UnitLength.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitLength, to: UnitLength) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitLength {
  static let allUnits: [String: UnitLength] = {
    Length.allCases.reduce(into: [String: UnitLength]()) { dict, type in
      switch type {
      case .angstroms:
        dict[type.rawValue] = .angstroms
      case .astronomicalUnits:
        dict[type.rawValue] = .astronomicalUnits
      case .centimeters:
        dict[type.rawValue] = .centimeters
      case .decameters:
        dict[type.rawValue] = .decameters
      case .decimeters:
        dict[type.rawValue] = .decimeters
      case .fathoms:
        dict[type.rawValue] = .fathoms
      case .feet:
        dict[type.rawValue] = .feet
      case .furlongs:
        dict[type.rawValue] = .furlongs
      case .hectometers:
        dict[type.rawValue] = .hectometers
      case .inches:
        dict[type.rawValue] = .inches
      case .kilometers:
        dict[type.rawValue] = .kilometers
      case .leagues:
        dict[type.rawValue] = .leagues
      case .lightyears:
        dict[type.rawValue] = .lightyears
      case .megameters:
        dict[type.rawValue] = .megameters
      case .meters:
        dict[type.rawValue] = .meters
      case .micrometers:
        dict[type.rawValue] = .micrometers
      case .miles:
        dict[type.rawValue] = .miles
      case .millimeters:
        dict[type.rawValue] = .millimeters
      case .nanometers:
        dict[type.rawValue] = .nanometers
      case .nauticalLeagues:
        dict[type.rawValue] = .nauticalLeagues
      case .nauticalMiles:
        dict[type.rawValue] = .nauticalMiles
      case .parsecs:
        dict[type.rawValue] = .parsecs
      case .picometers:
        dict[type.rawValue] = .picometers
      case .scandinavianMiles:
        dict[type.rawValue] = .scandinavianMiles
      case .yards:
        dict[type.rawValue] = .yards
      }
    }
  }()
  
  static let allCases: [UnitLength] =
  Length.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitLength? {
    if let v = UnitLength.value(forKey: self) {
      if let value = v as? UnitLength {
        return value
      }
    }

    return nil
  }
}

extension UnitLength {
  static var nauticalLeagues: UnitLength {
    // 1 nauticalLeague = 5556 meters
    return UnitLength(
      symbol: "3NM",
      converter: UnitConverterLinear(coefficient: 5556))
  }
  
  static var leagues: UnitLength {
    // 1 league = 4828 meters
    return UnitLength(
      symbol: "leag",
      converter: UnitConverterLinear(coefficient: 4828))
  }
  
  static var angstroms: UnitLength {
    // 1 angstrom = .00000000001 meters
    return UnitLength(
      symbol: "Å",
      converter: UnitConverterLinear(coefficient: 1.0e-10))
  }
}

/// UnitLength = UnitSpeed * UnitDuration
/// ⇔ UnitSpeed = UnitLength / UnitDuration
extension UnitLength: UnitProduct {
  typealias Factor1 = UnitSpeed
  typealias Factor2 = UnitDuration
  typealias Product = UnitLength
  
  static func defaultUnitMapping() -> (UnitSpeed, UnitDuration, UnitLength) {
    return (.metersPerSecond, .seconds, .meters)
  }
}

