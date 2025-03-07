//
//  Duration.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Duration: String, CaseIterable, Identifiable {
  case hours = "Hours"
  case minutes = "Minutes"
  case seconds = "Seconds"
  case milliseconds = "Milliseconds"
  case microseconds = "Microseconds"
  case nanoseconds = "Nanoseconds"
  case picoseconds = "Picoseconds"
  
  var id: String { self.rawValue }
  var symbol: String { Duration.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitDuration? {
    if let unit = UnitDuration.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitDuration, to: UnitDuration) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitDuration {
  static let allUnits: [String: UnitDuration] = {
    Duration.allCases.reduce(into: [String: UnitDuration]()) { dict, type in
      switch type {
      case .hours:
        dict[type.rawValue] = .hours
      case .minutes:
        dict[type.rawValue] = .minutes
      case .seconds:
        dict[type.rawValue] = .seconds
      case .milliseconds:
        dict[type.rawValue] = .milliseconds
      case .microseconds:
        dict[type.rawValue] = .microseconds
      case .nanoseconds:
        dict[type.rawValue] = nanoseconds
      case .picoseconds:
        dict[type.rawValue] = .picoseconds
      }
    }
  }()
  
    static let allCases: [UnitDuration] =
    Duration.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitDuration? {
    if let v = UnitDuration.value(forKey: self) {
      if let value = v as? UnitDuration {
        return value
      }
    }
    
    return nil
  }
}
