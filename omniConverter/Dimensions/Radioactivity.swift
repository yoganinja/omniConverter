//
//  Radioactivity.swift
//  omniConverter
//
//  Created by John Florian on 7/30/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

//@available(iOS 10.0, *)
//open class UnitRadioactivity : Dimension, NSSecureCoding {
//
//
//    @NSCopying open class var becquerel: UnitRadioactivity { get }
//
//    @NSCopying open class var curie: UnitRadioactivity { get }
//
//    @NSCopying open class var disintegrationsPerSecond: UnitRadioactivity { get }
//
//    @NSCopying open class var gigabecquerel: UnitRadioactivity { get }
//
//    @NSCopying open class var kilobecquerel: UnitRadioactivity { get }
//
//    @NSCopying open class var microcurie: UnitRadioactivity { get }
//
//    @NSCopying open class var millicurie: UnitRadioactivity { get }
//
//    @NSCopying open class var megabecquerel: UnitRadioactivity { get }
//
//    @NSCopying open class var nanocurie: UnitRadioactivity { get }
//
//    @NSCopying open class var picocurie: UnitRadioactivity { get }
//
//    @NSCopying open class var rutherford: UnitRadioactivity { get }
//
//    @NSCopying open class var terabecquerel: UnitRadioactivity { get }
//}
//
//extension UnitRadioactivity {
//
//    /// Creates a `UnitRadioactivity` which the specified `locale` prefers for the specific `usage`.
//    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
//    public convenience init(forLocale: Locale, usage: MeasurementFormatUnitUsage<UnitRadioactivity> = .general)
//}
//
//@available(*, unavailable)
//extension UnitRadioactivity : @unchecked Sendable {
//}

enum Radioactivity: String, CaseIterable, Identifiable {
  case becquerel = "Becquerel"
  case curie = "Curie"
  case disintegrationsPerSecond = "Disintegrations per Second"
  case gigabecquerel = "Gigabecquerel"
  case kilobecquerel = "Kilobecquerel"
  case microcurie = "Microcurie"
  case millicurie = "Millicurie"
  case megabecquerel = "Megabecquerel"
  case nanocurie = "Nanocurie"
  case picocurie = "Picocurie"
  case rutherford = "Rutherford"
  case terabecquerel = "Terabecquerel"
  
  var id: String { self.rawValue }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitRadioactivity? {
    if let unit = UnitRadioactivity.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitRadioactivity, to: UnitRadioactivity) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitRadioactivity {
  static let allUnits: [String: UnitRadioactivity] = {
    Radioactivity.allCases.reduce(into: [String: UnitRadioactivity]()) { dict, type in
      switch type {
      case .becquerel:
        dict[type.rawValue] = .becquerel
      case .curie:
        dict[type.rawValue] = .curie
      case .disintegrationsPerSecond:
        dict[type.rawValue] = .disintegrationsPerSecond
      case .gigabecquerel:
        dict[type.rawValue] = .gigabecquerel
      case .kilobecquerel:
        dict[type.rawValue] = .kilobecquerel
      case .microcurie:
        dict[type.rawValue] = .microcurie
      case .millicurie:
        dict[type.rawValue] = .millicurie
      case .megabecquerel:
        dict[type.rawValue] = .megabecquerel
      case .nanocurie:
        dict[type.rawValue] = .nanocurie
      case .picocurie:
        dict[type.rawValue] = .picocurie
      case .rutherford:
        dict[type.rawValue] = .rutherford
      case .terabecquerel:
        dict[type.rawValue] = .terabecquerel
      }
    }
  }()
  
  static let allCases: [UnitRadioactivity] =
  Radioactivity.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitRadioactivity? {
    if let v = UnitRadioactivity.value(forKey: self) {
      if let value = v as? UnitRadioactivity {
        return value
      }
    }
    
    return nil
  }
}

final class UnitRadioactivity: Dimension, KeyValueCodable {
  static var _codables: [KeyValueCodableTypeInfo] { return [ _idKey, _fnameKey, _bitKey ]}
  static var _keyValueCodableStore: Dictionary<String, Any> = [:]
  
  static var id: Int {
    get { return UnitRadioactivity.getValue(forKey: "id") as Int }
    set { UnitRadioactivity.setValue(value: newValue, forKey: "id") }
  }
  
  static var fname: UnitRadioactivity {
    get { return UnitRadioactivity.getValue(forKey: "fname") as UnitRadioactivity }
    set { UnitRadioactivity.setValue(value: newValue, forKey: "fname") }
  }
  
  static var bit: UnitRadioactivity {
    get { return UnitRadioactivity(symbol: "Bit", converter: UnitConverterLinear(coefficient: 1.0)) }
    set { UnitRadioactivity.setValue(value: newValue, forKey: "bit") }
  }
  
  static let becquerel = UnitRadioactivity(symbol: "Bq", converter: UnitConverterLinear(coefficient: 1.0))
  static let curie = UnitRadioactivity(symbol: "Ci", converter: UnitConverterLinear(coefficient: 3.7e10))
  static let disintegrationsPerSecond = UnitRadioactivity(symbol: "dps", converter: UnitConverterLinear(coefficient: 1.0))
  static let gigabecquerel = UnitRadioactivity(symbol: "GBq", converter: UnitConverterLinear(coefficient: 1000000000.0))
  static let kilobecquerel = UnitRadioactivity(symbol: "kBq", converter: UnitConverterLinear(coefficient: 1000.0))
  static let microcurie = UnitRadioactivity(symbol: "µCi", converter: UnitConverterLinear(coefficient: 3.7e4))
  static let millicurie = UnitRadioactivity(symbol: "mCi", converter: UnitConverterLinear(coefficient: 3.7e7))
  static let megabecquerel = UnitRadioactivity(symbol: "MBq", converter: UnitConverterLinear(coefficient: 1000000.0))
  static let nanocurie = UnitRadioactivity(symbol: "nCi", converter: UnitConverterLinear(coefficient: 3.7e1))
  static let picocurie = UnitRadioactivity(symbol: "pCi", converter: UnitConverterLinear(coefficient: 3.7e-2))
  static let rutherford = UnitRadioactivity(symbol: "rd", converter: UnitConverterLinear(coefficient: 1000000.0))
  static let terabecquerel = UnitRadioactivity(symbol: "TBq", converter: UnitConverterLinear(coefficient: 1000000000000.0))
  
  override class func baseUnit() -> UnitRadioactivity {
    return .becquerel
  }
}

extension UnitRadioactivity {
  private static let _idKey = KeyValueCodableTypeInfo(key: "id", type: Int.self)
  private static let _fnameKey = KeyValueCodableTypeInfo(key: "fname", type: UnitRadioactivity.self)
  private static let _bitKey = KeyValueCodableTypeInfo(key: "bit", type: UnitRadioactivity.self)
}
