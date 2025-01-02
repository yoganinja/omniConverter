//
//  Illuminance.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Illuminance: String, CaseIterable, Identifiable {
  case lux = "Lux"
//  case nox = "Nox"
//  case phot = "Phot"
//  case kilolux = "Kilolux"
//  case lumenPerCentimeter = "Lumen per Centimeter"
//  case lumenPerMeter = "Lumen per Meter"
//  case lumenPerFoot = "Lumen per Foot"
//  case lumenPerInch = "Lumen per Inch"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitIlluminance? {
    if let unit = UnitIlluminance.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitIlluminance, to: UnitIlluminance) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitIlluminance {
  static let allUnits: [String: UnitIlluminance] = {
    Illuminance.allCases.reduce(into: [String: UnitIlluminance]()) { dict, type in
      switch type {
      case .lux:
        dict[type.rawValue] = .lux
      }
    }
  }()
  
  static let allCases: [UnitIlluminance] =
  Illuminance.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitIlluminance? {
    if let v = UnitIlluminance.value(forKey: self) {
      if let value = v as? UnitIlluminance {
        return value
      }
    }
    
    return nil
  }
}
