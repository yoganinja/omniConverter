//
//  Length.swift
//  omniConverter
//
//  Created by John Florian on 7/11/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

//struct LengthUnit: ConvertibleUnit {
//    static func convert(value: Double, from inputUnit: UnitLength, to outputUnit: UnitLength) -> Double {
//        let inputMeasurement = Measurement(value: value, unit: inputUnit)
//        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
//        return outputMeasurement.value
//    }
//}

enum Length: String, CaseIterable, Identifiable { //, ConvertibleUnit {
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
  
//  static var allUnitCases: [UnitLength] {
//    get {
//      return toUnitCases(allStringCases: allCases.toStrings)
//    }
//  }
  
//  var toString: String {
//    get {
//      return String(describing: self)
//    }
//  }
  
  static func name(from stringName: String) -> UnitLength? {
    if let aaa = UnitLength.allUnits[stringName] {
      return aaa
    } else {
      return nil
    }
    
    
//    for item in allCases {
//      if String(describing: item).stripSpaces.lowercased() == stringName.stripSpaces.lowercased() {
//        let itemIndex = allCases.firstIndex(of: item)
//        let lookupItem = allUnitCases[itemIndex!]
//        return lookupItem
//      }
//    }
//    
//    return nil
  }
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = self.name(from: stringFrom)
    let to = self.name(from: stringTo)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from inputUnit: UnitLength, to outputUnit: UnitLength) -> Double {
      let inputMeasurement = Measurement(value: value, unit: inputUnit)
      let outputMeasurement = inputMeasurement.converted(to: outputUnit)
    let output = outputMeasurement.value
    return output
  }
  
//  static func convert(value: Double, from: UnitLength, to: UnitLength) -> Double {
//    return Measurement(value: value, unit: from).converted(to: to).value
//  }
}

extension UnitLength {
  static let allUnits: [String: UnitLength] = [
    "Angstroms": .angstroms,
    "Astronomical Units": .astronomicalUnits,
    "Centimeters": .centimeters,
    "Decameters": .decameters,
    "Decimeters": .decimeters,
    "Fathoms": .fathoms,
    "Feet": .feet,
    "Furlongs": .furlongs,
    "Hectometers": .hectometers,
    "Inches": .inches,
    "Kilometers": .kilometers,
    "Leagues": .leagues,
    "Lightyears": .lightyears,
    "Megameters": .megameters,
    "Meters": .meters,
    "Micrometers": .micrometers,
    "Miles": .miles,
    "Millimeters": .millimeters,
    "Nanometers": .nanometers,
    "Nautical Leagues": .nauticalLeagues,
    "Nautical Miles": .nauticalMiles,
    "Parsecs": .parsecs,
    "Picometers": .picometers,
    "Scandinavian Miles": .scandinavianMiles,
    "Yards": .yards
  ]
}

//extension UnitLength {
//    static let allUnits: [String: UnitLength] = [
//        "meters": .meters,
//        "kilometers": .kilometers,
//        "inches": .inches,
//        "feet": .feet,
//        "yards": .yards,
//        "miles": .miles
//    ]
//}

extension UnitLength {
  static var nauticalLeagues: UnitLength {
    // 1 nauticalLeague = 5556 meters
    return UnitLength(symbol: "3NM",
                      converter: UnitConverterLinear(coefficient: 5556))
  }
  
  static var leagues: UnitLength {
    // 1 league = 4828 meters
    return UnitLength(symbol: "leag",
                      converter: UnitConverterLinear(coefficient: 4828))
  }
  
  static var angstroms: UnitLength {
    // 1 angstrom = .00000000001 meters
    return UnitLength(symbol: "Å",
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

extension String {
//  var unit: UnitLength? {
//    return self.toUnit(of: UnitLength.self)
//  }
  
//  fileprivate var toUnit: UnitLength? {
//    if let v = UnitLength.value(forKey: self) {
//      if let value = v as? UnitLength {
//        return value
//      }
//    }
//
//    return nil
//  }
}

