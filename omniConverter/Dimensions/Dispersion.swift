//
//  Dispersion.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Dispersion: String, CaseIterable, Identifiable {
  case partsPerMillion = "Parts per Million"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitDispersion? {
    if let unit = UnitDispersion.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitDispersion, to: UnitDispersion) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitDispersion {
  static let allUnits: [String: UnitDispersion] = {
    Dispersion.allCases.reduce(into: [String: UnitDispersion]()) { dict, type in
      switch type {
      case .partsPerMillion:
        dict[type.rawValue] = .partsPerMillion
      }
    }
  }()
  
  static let allCases: [UnitDispersion] =
  Dispersion.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitDispersion? {
    if let v = UnitDispersion.value(forKey: self) {
      if let value = v as? UnitDispersion {
        return value
      }
    }
    
    return nil
  }
}
