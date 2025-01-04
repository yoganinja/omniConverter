//
//  Area.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Area: String, CaseIterable, Identifiable {
  case acres = "Acres"
  case ares = "Ares"
  case hectares = "Hectares"
  case squareCentimeters = "Square Centimeters"
  case squareFeet = "Square Feet"
  case squareInches = "Square Inches"
  case squareKilometers = "Square Kilometers"
  case squareMegameters = "Square Megameters"
  case squareMeters = "Square Meters"
  case squareMicrometers = "Square Micrometers"
  case squareMiles = "Square Miles"
  case squareMillimeters = "Square Millimeters"
  case squareNanometers = "Square Nanometers"
  case squareYards = "Square Yards"
  case cents = "Cents"
  case shaku = "Shaku"
  case go = "Gō"
  case jo = "Jō"
  case tsubo = "Tsubo"
  case se = "Se"
  case tan = "Tan"
  case cho = "Chō"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitArea? {
    if let unit = UnitArea.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitArea, to: UnitArea) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitArea {
  static let allUnits: [String: UnitArea] = {
    Area.allCases.reduce(into: [String: UnitArea]()) { dict, type in
      switch type {
      case .acres:
        dict[type.rawValue] = .acres
      case .ares:
        dict[type.rawValue] = .ares
      case .hectares:
        dict[type.rawValue] = .hectares
      case .squareCentimeters:
        dict[type.rawValue] = .squareCentimeters
      case .squareFeet:
        dict[type.rawValue] = .squareFeet
      case .squareInches:
        dict[type.rawValue] = .squareInches
      case .squareKilometers:
        dict[type.rawValue] = .squareKilometers
      case .squareMegameters:
        dict[type.rawValue] = .squareMegameters
      case .squareMeters:
        dict[type.rawValue] = .squareMeters
      case .squareMicrometers:
        dict[type.rawValue] = .squareMicrometers
      case .squareMiles:
        dict[type.rawValue] = .squareMiles
      case .squareMillimeters:
        dict[type.rawValue] = .squareMillimeters
      case .squareNanometers:
        dict[type.rawValue] = .squareNanometers
      case .squareYards:
        dict[type.rawValue] = .squareYards
      case .cents:
        dict[type.rawValue] = .cents
      case .tsubo:
        dict[type.rawValue] = .tsubo
      case .shaku:
        dict[type.rawValue] = .shaku
      case .go:
        dict[type.rawValue] = .go
      case .jo:
        dict[type.rawValue] = .jo
      case .se:
        dict[type.rawValue] = .se
      case .tan:
        dict[type.rawValue] = .tan
      case .cho:
        dict[type.rawValue] = .cho
      }
    }
  }()
  
  static let allCases: [UnitArea] =
  Area.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitArea? {
    if let v = UnitArea.value(forKey: self) {
      if let value = v as? UnitArea {
        return value
      }
    }
    
    return nil
  }
}

extension UnitArea {
  static var cents: UnitArea {
    // 1 cent = 40.46856 square meters
    return UnitArea(
      symbol: "cent",
      converter: UnitConverterLinear(coefficient: 40.46856))
  }
  
  static var shaku: UnitArea {
    // 1 shaku = 4/121 square meters
    return UnitArea(
      symbol: "勺",
      converter: UnitConverterLinear(coefficient: 4/121))
  }
  
  static var go: UnitArea {
    // 1 go = 40/121 square meters
    return UnitArea(
      symbol: "合",
      converter: UnitConverterLinear(coefficient: 40/121))
  }
  
  static var jo: UnitArea {
    // 1 jo = 200/121 square meters
    return UnitArea(
      symbol: "帖",
      converter: UnitConverterLinear(coefficient: 200/121))
  }
  
  static var tsubo: UnitArea {
    // 1 tsubo = 400/121 square meters
    return UnitArea(
      symbol: "坪",
      converter: UnitConverterLinear(coefficient: 400/121))
  }
  
  static var se: UnitArea {
    // 1 tsubo = 12000/121 square meters
    return UnitArea(
      symbol: "畝",
      converter: UnitConverterLinear(coefficient: 12000/121))
  }
  
  static var tan: UnitArea {
    // 1 tsubo = 120000/121 square meters
    return UnitArea(
      symbol: "反",
      converter: UnitConverterLinear(coefficient: 120000/121))
  }
  
  static var cho: UnitArea {
    // 1 tsubo = 1200000/121 square meters
    return UnitArea(
      symbol: "町",
      converter: UnitConverterLinear(coefficient: 1200000/121))
  }
}
