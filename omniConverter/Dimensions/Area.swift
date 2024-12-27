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

  static var allUnitCases: [UnitArea] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  /// Unit representation of a case
  var toUnit: UnitArea? {
    get {
      if let _ = Area.allCases.firstIndex(of: self) {
        return self.rawValue.toUnit
      }
      
      return nil
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  //    static func name(from stringName: String) -> UnitArea? {
  //        for item in allCases {
  //            if String(describing: item).stripSpaces.lowercased() == stringName.stripSpaces.lowercased() {
  //                let itemIndex = allCases.index(of: item)
  //                let lookupItem = allUnitCases[itemIndex!]
  //                return lookupItem
  //            }
  //        }
  //
  //        return nil
  //    }
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = stringFrom.toUnit // self.name(from: stringFrom)
    let to = stringTo.toUnit // self.name(from: stringTo)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitArea, to: UnitArea) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitArea {
  static let allUnits: [String: UnitArea] = [
    "Acres": .acres,
    "Ares": .ares,
    "Hectares": .hectares,
    "Square Centimeters": .squareCentimeters,
    "Square Feet": .squareFeet,
    "Square Inches": .squareInches,
    "Square Kilometers": .squareKilometers,
    "Square Megameters": .squareMegameters,
    "Square Meters": .squareMeters,
    "Square Micrometers": .squareMicrometers,
    "Square Miles": .squareMiles,
    "Square Millimeters": .squareMillimeters,
    "Square Nanometers": .squareNanometers,
    "Square Yards": .squareYards
  ]
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

