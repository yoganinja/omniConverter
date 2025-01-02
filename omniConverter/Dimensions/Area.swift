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
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitArea? {
    if let unit = UnitArea.allUnits[name] {
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
