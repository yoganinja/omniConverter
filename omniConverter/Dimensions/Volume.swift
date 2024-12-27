//
//  Volume.swift
//  omniConverter
//
//  Created by John Florian on 7/18/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Volume: String, CaseIterable, Identifiable {
  case acreFeet = "Acre Feet"
  case bushels = "Bushels"
  case centiliters = "Centiliters"
  case cubicCentimeters = "Cubic Centimeters"
  case cubicDecimeters = "Cubic Decimeters"
  case cubicFeet = "Cubic Feet"
  case cubicInches = "Cubic Inches"
  case cubicKilometers = "Cubic Kilometers"
  case cubicMeters = "Cubic Meters"
  case cubicMiles = "Cubic Miles"
  case cubicMillimeters = "Cubic Millimeters"
  case cubicYards = "Cubic Yards"
  case cups = "Cups"
  case deciliters = "Deciliters"
  case fluidOunces = "Fluid Ounces"
  case gallons = "Gallons"
  case imperialFluidOunces = "Imperial Fluid Ounces"
  case imperialGallons = "Imperial Gallons"
  case imperialPints = "Imperial Pints"
  case imperialQuarts = "Imperial Quarts"
  case imperialTablespoons = "Imperial Tablespoons"
  case imperialTeaspoons = "Imperial Teaspoons"
  case kiloliters = "Kiloliters"
  case liters = "Liters"
  case megaliters = "Megaliters"
  case metricCups = "Metric Cups"
  case milliliters = "Milliliters"
  case pints = "Pints"
  case quarts = "Quarts"
  case tablespoons = "Tablespoons"
  case teaspoons = "Teaspoons"
  
  var id: String { self.rawValue }
  
  static var allUnitCases: [UnitVolume] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitVolume? {
    for item in allCases {
      if String(describing: item).stripSpaces.lowercased() == stringName.stripSpaces.lowercased() {
        let itemIndex = allCases.firstIndex(of: item)
        let lookupItem = allUnitCases[itemIndex!]
        return lookupItem
      }
    }
    
    return nil
  }
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = self.name(from: stringFrom)
    let to = self.name(from: stringTo)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitVolume, to: UnitVolume) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitVolume {
  static let allUnits: [String: UnitVolume] = [
    "Acre Feet": .acreFeet,
    "Bushels": .bushels,
    "Centiliters": .centiliters,
    "Cubic Centimeters": .cubicCentimeters,
    "Cubic Decimeters": .cubicDecimeters,
    "Cubic Feet": .cubicFeet,
    "Cubic Inches": .cubicInches,
    "Cubic Kilometers": .cubicKilometers,
    "Cubic Meters": .cubicMeters,
    "Cubic Miles": .cubicMiles,
    "Cubic Millimeters": .cubicMillimeters,
    "Cubic Yards": .cubicYards,
    "Cups": .cups,
    "Deciliters": .deciliters,
    "Fluid Ounces": .fluidOunces,
    "Gallons": .gallons,
    "Imperial Fluid Ounces": .imperialFluidOunces,
    "Imperial Gallons": .imperialGallons,
    "Imperial Pints": .imperialPints,
    "Imperial Quarts": .imperialQuarts,
    "Imperial Tablespoons": .imperialTablespoons,
    "Imperial Teaspoons": .imperialTeaspoons,
    "Kiloliters": .kiloliters,
    "Liters": .liters,
    "Megaliters": .megaliters,
    "Metric Cups": .metricCups,
    "Milliliters": .milliliters,
    "Pints": .pints,
    "Quarts": .quarts,
    "Tablespoons": .tablespoons,
    "Teaspoons": .teaspoons
  ]
}

extension String {
  fileprivate var toUnit: UnitVolume? {
    if let v = UnitVolume.value(forKey: self) {
      if let value = v as? UnitVolume {
        return value
      }
    }
    
    return nil
  }
}
