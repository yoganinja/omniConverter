//
//  Frequency.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Frequency: String, CaseIterable, Identifiable {
  case gigahertz = "Gigahertz"
  case hertz = "Hertz"
  case kilohertz = "Kilohertz"
  case megahertz = "Megahertz"
  case microhertz = "Microhertz"
  case millihertz = "Millihertz"
  case nanohertz = "Nanohertz"
  case terahertz = "Terahertz"
  case framesPerSecond = "Frames per Second"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitFrequency? {
    if let unit = UnitFrequency.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitFrequency, to: UnitFrequency) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitFrequency {
  static let allUnits: [String: UnitFrequency] = {
    Frequency.allCases.reduce(into: [String: UnitFrequency]()) { dict, type in
      switch type {
      case .gigahertz:
        dict[type.rawValue] = .gigahertz
      case .hertz:
        dict[type.rawValue] = .hertz
      case .kilohertz:
        dict[type.rawValue] = .kilohertz
      case .megahertz:
        dict[type.rawValue] = .megahertz
      case .microhertz:
        dict[type.rawValue] = .microhertz
      case .millihertz:
        dict[type.rawValue] = .millihertz
      case .nanohertz:
        dict[type.rawValue] = .nanohertz
      case .terahertz:
        dict[type.rawValue] = .terahertz
      case .framesPerSecond:
        dict[type.rawValue] = .framesPerSecond
      }
    }
  }()
  
  static let allCases: [UnitFrequency] =
  Frequency.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitFrequency? {
    if let v = UnitFrequency.value(forKey: self) {
      if let value = v as? UnitFrequency {
        return value
      }
    }
    
    return nil
  }
}
