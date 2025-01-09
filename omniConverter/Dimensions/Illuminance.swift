//
//  Illuminance.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Illuminance: String, CaseIterable, Identifiable {
  case phot = "Phot"
  case kilolux = "Kilolux"
  case footcandle = "Foot-Candle"
  case metercandle = "Meter-Candle"
  case lux = "Lux"
  case millilux = "Millilux"
  case nox = "Nox"
//  case lumenPerCentimeter = "Lumen per Centimeter"
//  case lumenPerMeter = "Lumen per Meter"
//  case lumenPerFoot = "Lumen per Foot"
//  case lumenPerInch = "Lumen per Inch"
  
  var id: String { self.rawValue }
  var symbol: String { Illuminance.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitIlluminance? {
    if let unit = UnitIlluminance.allUnits[name] {
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
      case .phot:
        dict[type.rawValue] = .phot
      case .kilolux:
        dict[type.rawValue] = .kilolux
      case .footcandle:
        dict[type.rawValue] = .footcandle
      case .metercandle:
        dict[type.rawValue] = .metercandle
      case .millilux:
        dict[type.rawValue] = .millilux
      case .nox:
        dict[type.rawValue] = .nox
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

extension UnitIlluminance {
  static var phot: UnitIlluminance {
    // 1 phot = 10000 lux
    return UnitIlluminance(
      symbol: "ph",
      converter: UnitConverterLinear(coefficient: 10000))
  }
  
  static var kilolux: UnitIlluminance {
    // 1 kilolux = 1000 lux
    return UnitIlluminance(
      symbol: "klx",
      converter: UnitConverterLinear(coefficient: 1000))
  }
  
  static var millilux: UnitIlluminance {
    // 1 millilux = 1/1000 lux
    return UnitIlluminance(
      symbol: "mlx",
      converter: UnitConverterLinear(coefficient: 1/1000))
  }
  
  static var nox: UnitIlluminance {
    // 1 nox = 1/1000 lux
    return UnitIlluminance(
      symbol: "nx",
      converter: UnitConverterLinear(coefficient: 1/1000))
  }
  
  static var footcandle: UnitIlluminance {
    // 1 footcandle = 10.764 lux
    return UnitIlluminance(
      symbol: "fc",
      converter: UnitConverterLinear(coefficient: 10.764))
  }
  
  static var metercandle: UnitIlluminance {
    // 1 metercandle = 1 lux
    return UnitIlluminance(
      symbol: "mc",
      converter: UnitConverterLinear(coefficient: 1))
  }
}
