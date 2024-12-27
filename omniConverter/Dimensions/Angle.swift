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

  static var allUnitCases: [UnitAngle] {
    get {
      return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  /// Unit representation of a case
  var toUnit: UnitAngle? {
    get {
      if let _ = Angle.allCases.firstIndex(of: self) {
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
  
  //    static func name(from stringName: String) -> UnitAngle? {
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
  
  static func convert(value: Double, from: UnitAngle, to: UnitAngle) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitAngle {
  static let allUnits: [String: UnitAngle] = [
    "Arc Minutes": .arcMinutes,
    "Arc Seconds": .arcSeconds,
    "Degrees": .degrees,
    "Gradians": .gradians,
    "Radians": .radians,
    "Revolutions": .revolutions
  ]
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
