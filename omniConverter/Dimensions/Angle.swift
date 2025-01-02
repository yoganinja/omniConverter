//
//  Angle.swift
//  omniConverter
//
//  Created by John Florian on 7/26/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Angle: String, CaseIterable, Identifiable {
  case arcMinutes = "Arc Minutes"
  case arcSeconds = "Arc Seconds"
  case degrees = "Degrees"
  case gradians = "Gradians"
  case radians = "Radians"
  case revolutions = "Revolutions"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitAngle? {
    if let unit = UnitAngle.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitAngle, to: UnitAngle) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitAngle {
  static let allUnits: [String: UnitAngle] = {
    Angle.allCases.reduce(into: [String: UnitAngle]()) { dict, type in
      switch type {
      case .arcMinutes:
        dict[type.rawValue] = .arcMinutes
      case .arcSeconds:
        dict[type.rawValue] = .arcSeconds
      case .degrees:
        dict[type.rawValue] = .degrees
      case .gradians:
        dict[type.rawValue] = .gradians
      case .radians:
        dict[type.rawValue] = .radians
      case .revolutions:
        dict[type.rawValue] = .revolutions
      }
    }
  }()
  
  static let allCases: [UnitAngle] =
  Angle.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitAngle? {
    if let v = UnitAngle.value(forKey: self) {
      if let value = v as? UnitAngle {
        return value
      }
    }
    
    return nil
  }
}
