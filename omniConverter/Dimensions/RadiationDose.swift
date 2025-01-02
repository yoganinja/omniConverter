//
//  RadiationDose.swift
//  omniConverter
//
//  Created by John Florian on 11/24/18.
//  Copyright © 2018 John Florian. All rights reserved.
//

import Foundation

enum RadiationDose: String, CaseIterable, Identifiable {
  case bit = "Bit"
  case centigray = "Centigray"
  case gray = "Gray"
  case microgray = "Microgray"
  case microrem = "Microrem"
  case microsievert = "Microsievert"
  case milligray = "Milligray"
  case millirem = "Millirem"
  case millisievert = "Millisievert"
  case rad = "Rad"
  case rem = "Rem"
  case sievert = "Sievert"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitRadiationDose? {
    if let unit = UnitRadiationDose.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitRadiationDose, to: UnitRadiationDose) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitRadiationDose {
  static let allUnits: [String: UnitRadiationDose] = {
    RadiationDose.allCases.reduce(into: [String: UnitRadiationDose]()) { dict, type in
      switch type {
      case .bit:
        dict[type.rawValue] = .bit
      case .centigray:
        dict[type.rawValue] = .centigray
      case .gray:
        dict[type.rawValue] = .gray
      case .microgray:
        dict[type.rawValue] = .microgray
      case .microrem:
        dict[type.rawValue] = .microrem
      case .microsievert:
        dict[type.rawValue] = .microsievert
      case .milligray:
        dict[type.rawValue] = .milligray
      case .millirem:
        dict[type.rawValue] = .millirem
      case .millisievert:
        dict[type.rawValue] = .millisievert
      case .rad:
        dict[type.rawValue] = .rad
      case .rem:
        dict[type.rawValue] = .rem
      case .sievert:
        dict[type.rawValue] = .sievert
      }
    }
  }()
  
  static let allCases: [UnitRadiationDose] =
  RadiationDose.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitRadiationDose? {
    if let v = UnitRadiationDose.value(forKey: self) {
      if let value = v as? UnitRadiationDose {
        return value
      }
    }
    
    return nil
  }
}





final class UnitRadiationDose: Dimension, KeyValueCodable {
  override init(symbol: String, converter: UnitConverter) {
    super.init(symbol: symbol, converter: converter)
    
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  static var _codables: [KeyValueCodableTypeInfo] { return [ _idKey, _fnameKey, _bitKey ]}
  static var _keyValueCodableStore: Dictionary<String, Any> = [:]
  
  static var id: Int {
    get { return UnitRadiationDose.getValue(forKey: "id") as Int }
    set { UnitRadiationDose.setValue(value: newValue, forKey: "id") }
  }
  
  static var fname: UnitRadiationDose {
    get { return UnitRadiationDose.getValue(forKey: "fname") as UnitRadiationDose }
    set { UnitRadiationDose.setValue(value: newValue, forKey: "fname") }
  }
  
  static var bit: UnitRadiationDose {
    get { return UnitRadiationDose(symbol: "Bit", converter: UnitConverterLinear(coefficient: 1.0)) }
    set { UnitRadiationDose.setValue(value: newValue, forKey: "bit") }
  }
  static var centigray: UnitRadiationDose {
    return UnitRadiationDose(symbol: "cGy", converter: UnitConverterLinear(coefficient: 1.0))
  }
  static var gray: UnitRadiationDose {
    return UnitRadiationDose(symbol: "Gy", converter: UnitConverterLinear(coefficient: 100.0))
  }
  static var microgray: UnitRadiationDose {
    return UnitRadiationDose(symbol: "µGy", converter: UnitConverterLinear(coefficient: 0.0001))
  }
  static var microrem: UnitRadiationDose {
    return UnitRadiationDose(symbol: "µrem", converter: UnitConverterLinear(coefficient: 0.000001))
  }
  static var microsievert: UnitRadiationDose {
    return UnitRadiationDose(symbol: "µSv", converter: UnitConverterLinear(coefficient: 0.0001))
  }
  static var milligray: UnitRadiationDose {
    return UnitRadiationDose(symbol: "mGy", converter: UnitConverterLinear(coefficient: 0.1))
  }
  static var millirem: UnitRadiationDose {
    return UnitRadiationDose(symbol: "mrem", converter: UnitConverterLinear(coefficient: 0.001))
  }
  static var millisievert: UnitRadiationDose {
    return UnitRadiationDose(symbol: "mSv", converter: UnitConverterLinear(coefficient: 0.1))
  }
  static var rad: UnitRadiationDose {
    return UnitRadiationDose(symbol: "rad", converter: UnitConverterLinear(coefficient: 1.0))
  }
  static var rem: UnitRadiationDose {
    return UnitRadiationDose(symbol: "rem", converter: UnitConverterLinear(coefficient: 1.0))
  }
  static var sievert: UnitRadiationDose {
    return UnitRadiationDose(symbol: "Sv", converter: UnitConverterLinear(coefficient: 100.0))
  }
  
  override class func baseUnit() -> UnitRadiationDose {
    return .rad
  }
}

extension UnitRadiationDose {
  private static let _idKey = KeyValueCodableTypeInfo(key: "id", type: Int.self)
  private static let _fnameKey = KeyValueCodableTypeInfo(key: "fname", type: UnitRadiationDose.self)
  private static let _bitKey = KeyValueCodableTypeInfo(key: "bit", type: UnitRadiationDose.self)
}
