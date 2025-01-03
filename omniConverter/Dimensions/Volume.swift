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
  case pecks = "Pecks"
  case pints = "Pints"
  case quarts = "Quarts"
  case tablespoons = "Tablespoons"
  case teaspoons = "Teaspoons"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitVolume? {
    if let unit = UnitVolume.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitVolume, to: UnitVolume) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitVolume {
  static let allUnits: [String: UnitVolume] = {
    Volume.allCases.reduce(into: [String: UnitVolume]()) { dict, type in
      switch type {
      case .acreFeet:
        dict[type.rawValue] = .acreFeet
      case .bushels:
        dict[type.rawValue] = .bushels
      case .centiliters:
        dict[type.rawValue] = .centiliters
      case .cubicCentimeters:
        dict[type.rawValue] = .cubicCentimeters
      case .cubicDecimeters:
        dict[type.rawValue] = .cubicDecimeters
      case .cubicFeet:
        dict[type.rawValue] = .cubicFeet
      case .cubicInches:
        dict[type.rawValue] = .cubicInches
      case .cubicKilometers:
        dict[type.rawValue] = .cubicKilometers
      case .cubicMeters:
        dict[type.rawValue] = .cubicMeters
      case .cubicMiles:
        dict[type.rawValue] = .cubicMiles
      case .cubicMillimeters:
        dict[type.rawValue] = .cubicMillimeters
      case .cubicYards:
        dict[type.rawValue] = .cubicYards
      case .cups:
        dict[type.rawValue] = .cups
      case .deciliters:
        dict[type.rawValue] = .deciliters
      case .fluidOunces:
        dict[type.rawValue] = .fluidOunces
      case .gallons:
        dict[type.rawValue] = .gallons
      case .imperialFluidOunces:
        dict[type.rawValue] = .imperialFluidOunces
      case .imperialGallons:
        dict[type.rawValue] = .imperialGallons
      case .imperialPints:
        dict[type.rawValue] = .imperialPints
      case .imperialQuarts:
        dict[type.rawValue] = .imperialQuarts
      case .imperialTablespoons:
        dict[type.rawValue] = .imperialTablespoons
      case .imperialTeaspoons:
        dict[type.rawValue] = .imperialTeaspoons
      case .kiloliters:
        dict[type.rawValue] = .kiloliters
      case .liters:
        dict[type.rawValue] = .liters
      case .megaliters:
        dict[type.rawValue] = .megaliters
      case .metricCups:
        dict[type.rawValue] = .metricCups
      case .milliliters:
        dict[type.rawValue] = .milliliters
      case .pecks:
        dict[type.rawValue] = .pecks
      case .pints:
        dict[type.rawValue] = .pints
      case .quarts:
        dict[type.rawValue] = .quarts
      case .tablespoons:
        dict[type.rawValue] = .tablespoons
      case .teaspoons:
        dict[type.rawValue] = .teaspoons
      }
    }
  }()
  
  static let allCases: [UnitVolume] =
  Volume.allCases.compactMap { $0.id.toUnit }
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

extension UnitVolume {
  static var pecks: UnitVolume {
    // 1 peck = 8.80976754172 liters
    return UnitVolume(
      symbol: "pk",
      converter: UnitConverterLinear(coefficient: 8.80976754172))
  }
}
