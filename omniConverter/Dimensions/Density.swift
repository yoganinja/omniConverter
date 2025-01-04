//
//  Density.swift
//  omniConverter
//
//  Created by John Florian on 8/4/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation
// UnitConcentrationMass
// millimolesPerLiter, milligramsPerDeciliter, gramsPerLiter
enum Density: String, CaseIterable, Identifiable {
  case gramsPerMilliliter = "Grams per Milliliter"
  case ouncesPerFluidOunce = "Ounces per Fluid Ounce"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitDensity? {
    if let unit = UnitDensity.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitDensity, to: UnitDensity) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitDensity {
  static let allUnits: [String: UnitDensity] = {
    Density.allCases.reduce(into: [String: UnitDensity]()) { dict, type in
      switch type {
      case .gramsPerMilliliter:
        dict[type.rawValue] = .gramsPerMilliliter
      case .ouncesPerFluidOunce:
        dict[type.rawValue] = .ouncesPerFluidOunce
      }
    }
  }()
  
  static let allCases: [UnitDensity] =
  Density.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitDensity? {
    if let v = UnitDensity.value(forKey: self) {
      if let value = v as? UnitDensity {
        return value
      }
    }
    
    return nil
  }
}

final class UnitDensity: Dimension, KeyValueCodable {
  static var _codables: [KeyValueCodableTypeInfo] { return [ _idKey, _fnameKey, _bitKey ]}
  static var _keyValueCodableStore: Dictionary<String, Any> = [:]
  
  static var id: Int {
    get { return UnitDensity.getValue(forKey: "id") as Int }
    set { UnitDensity.setValue(value: newValue, forKey: "id") }
  }
  
  static var fname: UnitDensity {
    get { return UnitDensity.getValue(forKey: "fname") as UnitDensity }
    set { UnitDensity.setValue(value: newValue, forKey: "fname") }
  }
  
  static var bit: UnitDensity {
    get { return UnitDensity(symbol: "Bit", converter: UnitConverterLinear(coefficient: 1.0)) }
    set { UnitDensity.setValue(value: newValue, forKey: "bit") }
  }
  
  static let gramsPerMilliliter = UnitDensity(symbol: "g/mL", converter: UnitConverterLinear(coefficient: 1.0))
  static let ouncesPerFluidOunce = UnitDensity(symbol: "oz/fl oz", converter: UnitConverterLinear(coefficient: 0.95861229))
  
  override class func baseUnit() -> UnitDensity {
    return .gramsPerMilliliter
  }
}

extension UnitDensity {
  private static let _idKey = KeyValueCodableTypeInfo(key: "id", type: Int.self)
  private static let _fnameKey = KeyValueCodableTypeInfo(key: "fname", type: UnitDensity.self)
  private static let _bitKey = KeyValueCodableTypeInfo(key: "bit", type: UnitDensity.self)
}
