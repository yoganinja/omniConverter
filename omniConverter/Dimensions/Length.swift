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
  case bananas = "Bananas"
  case chains = "Chains"
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
  case lightyears = "Light-Years"
  case lightdays = "Light-Days"
  case lighthours = "Light-Hours"
  case lightminutes = "Light-Minutes"
  case lightseconds = "Light-Seconds"
  case megameters = "Megameters"
  case meters = "Meters"
  case microinches = "Microinches"
  case micrometers = "Micrometers"
  case miles = "Miles"
  case millimeters = "Millimeters"
  case nanometers = "Nanometers"
  case nauticalLeagues = "Nautical Leagues"
  case nauticalMiles = "Nautical Miles"
  case parsecs = "Parsecs"
  case picometers = "Picometers"
  case rods = "Rods"
  case steps = "Steps"
  case thous = "Thous"
  case scandinavianMiles = "Scandinavian Miles"
  case yards = "Yards"
  case mo = "Mō"
  case rin = "Rin"
  case bu = "Bu"
  case sun = "Sun"
  case shaku = "Shaku"
  case ken = "Ken"
  case hiro = "Hiro"
  case jo = "Jō"
  case cho = "Chō"
  case ri = "Ri"
  
  var id: String { self.rawValue }
  var symbol: String { Length.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitLength? {
    if let unit = UnitLength.allUnits[name] {
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
      case .bananas:
        dict[type.rawValue] = .bananas
      case .chains:
        dict[type.rawValue] = .chains
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
      case .lightdays:
        dict[type.rawValue] = .lightdays
      case .lighthours:
        dict[type.rawValue] = .lighthours
      case .lightminutes:
        dict[type.rawValue] = .lightminutes
      case .lightseconds:
        dict[type.rawValue] = .lightseconds
      case .megameters:
        dict[type.rawValue] = .megameters
      case .meters:
        dict[type.rawValue] = .meters
      case .microinches:
        dict[type.rawValue] = .microinches
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
      case .rods:
        dict[type.rawValue] = .rods
      case .steps:
        dict[type.rawValue] = .steps
      case .thous:
        dict[type.rawValue] = .thous
      case .mo:
        dict[type.rawValue] = .mo
      case .rin:
        dict[type.rawValue] = .rin
      case .bu:
        dict[type.rawValue] = .bu
      case .sun:
        dict[type.rawValue] = .sun
      case .shaku:
        dict[type.rawValue] = .shaku
      case .ken:
        dict[type.rawValue] = .ken
      case .hiro:
        dict[type.rawValue] = .hiro
      case .jo:
        dict[type.rawValue] = .jo
      case .cho:
        dict[type.rawValue] = .cho
      case .ri:
        dict[type.rawValue] = .ri
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
      converter: UnitConverterLinear(coefficient: 4828.0417))
  }
  
  static var angstroms: UnitLength {
    // 1 angstrom = .00000000001 meters
    return UnitLength(
      symbol: "Å",
      converter: UnitConverterLinear(coefficient: 1.0e-10))
  }
  
  static var chains: UnitLength {
    // 1 chain = 20.116840233700003 meters
    return UnitLength(
      symbol: "ch",
      converter: UnitConverterLinear(coefficient: 20.116840233700003))
  }
  
  static var microinches: UnitLength {
    // 1 microinch = 0.0000000254 meters
    return UnitLength(
      symbol: "μin",
      converter: UnitConverterLinear(coefficient: 0.0000000254))
  }
  
  static var lightdays: UnitLength {
    // 1 lightday = 25902068371000.003 meters
    return UnitLength(
      symbol: "l-day",
      converter: UnitConverterLinear(coefficient: 25902068371000.003))
  }
  
  static var lighthours: UnitLength {
    // 1 lighthour = 1079252848800 meters
    return UnitLength(
      symbol: "l-hr",
      converter: UnitConverterLinear(coefficient: 1079252848800))
  }
  
  static var lightminutes: UnitLength {
    // 1 lightminute = 17987547480 meters
    return UnitLength(
      symbol: "l-min",
      converter: UnitConverterLinear(coefficient: 17987547480))
  }
  
  static var lightseconds: UnitLength {
    // 1 lightsecond = 299792458 meters
    return UnitLength(
      symbol: "l-sec",
      converter: UnitConverterLinear(coefficient: 299792458))
  }
  
  static var rods: UnitLength {
    // 1 rod = 5.029 meters
    return UnitLength(
      symbol: "rod",
      converter: UnitConverterLinear(coefficient: 5.029))
  }
  
  static var steps: UnitLength {
    // 1 step = 0.762 meters
    return UnitLength(
      symbol: "step",
      converter: UnitConverterLinear(coefficient: 0.762))
  }
  
  static var thous: UnitLength {
    // 1 thou = 0.0000254 meters
    return UnitLength(
      symbol: "th",
      converter: UnitConverterLinear(coefficient: 0.0000254))
  }
  
  static var bananas: UnitLength {
    // 1 banana = 0.0000254 meters
    return UnitLength(
      symbol: "bnna",
      converter: UnitConverterLinear(coefficient: 0.1905))
  }
  
  static var mo: UnitLength {
    // 1 mo = 0.0000254 meters
    return UnitLength(
      symbol: "毛",
      converter: UnitConverterLinear(coefficient: 1/33000))
  }
  
  static var rin: UnitLength {
    // 1 rin = 0.0000254 meters
    return UnitLength(
      symbol: "厘",
      converter: UnitConverterLinear(coefficient: 1/3300))
  }
  
  static var bu: UnitLength {
    // 1 bu = 0.0000254 meters
    return UnitLength(
      symbol: "分",
      converter: UnitConverterLinear(coefficient: 1/330))
  }
  
  static var sun: UnitLength {
    // 1 sun = 0.0000254 meters
    return UnitLength(
      symbol: "寸",
      converter: UnitConverterLinear(coefficient: 1/33))
  }
  
  static var shaku: UnitLength {
    // 1 shaku = 0.0000254 meters
    return UnitLength(
      symbol: "尺",
      converter: UnitConverterLinear(coefficient: 10/33))
  }
  
  static var ken: UnitLength {
    // 1 ken = 0.0000254 meters
    return UnitLength(
      symbol: "間",
      converter: UnitConverterLinear(coefficient: 20/11))
  }
  
  static var hiro: UnitLength {
    // 1 hiro = 0.0000254 meters
    return UnitLength(
      symbol: "尋",
      converter: UnitConverterLinear(coefficient: 20/11))
  }
  
  static var jo: UnitLength {
    // 1 jo = 0.0000254 meters
    return UnitLength(
      symbol: "丈",
      converter: UnitConverterLinear(coefficient: 100/33))
  }
  
  static var cho: UnitLength {
    // 1 cho = 0.0000254 meters
    return UnitLength(
      symbol: "町",
      converter: UnitConverterLinear(coefficient: 1200/11))
  }
  
  static var ri: UnitLength {
    // 1 ri = 0.0000254 meters
    return UnitLength(
      symbol: "里",
      converter: UnitConverterLinear(coefficient: 43200/11))
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

