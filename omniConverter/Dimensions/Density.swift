//
//  Density.swift
//  omniConverter
//
//  Created by John Florian on 8/4/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Density: String, CaseIterable, Identifiable {
  case gramsPerMilliliter = "Grams per Milliliter"
  case ouncesPerFluidOunce = "Ounces per Fluid Ounce"
  
  var id: String { self.rawValue }

  static var allUnitCases: [UnitDensity] {
    get {
      return Density.toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  private static func toUnitCases(allStringCases: [String]) -> [UnitDensity] {
    return allCases.map({
      $0.toUnit!
    })
    
    //            var collection: [UnitDensity] = []
    //            for item in allStringCases {
    //                if let value = UnitDensity.value(forKey: item) as? UnitDensity {
    //                    collection.append(value)
    //                }
    //            }
    //
    //            return collection
  }
  
  /// Unit representation of a case
  var toUnit: UnitDensity? {
    get {
      if let _ = Density.allCases.firstIndex(of: self) {
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
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = stringFrom.toUnit
    let to = stringTo.toUnit
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitDensity, to: UnitDensity) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
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

extension UnitDensity {
  static let allUnits: [String: UnitDensity] = [
    "Grams per Milliliter": .gramsPerMilliliter,
    "Ounces per Fluid Ounce": .ouncesPerFluidOunce
  ]
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
  
  //    func toDensityUnit() -> UnitDensity? {
  //        for item in Density.allCases {
  //            if item.toString == self {
  //                let itemIndex = Density.allCases.index(of: item)
  //                let v = Density.allCases.toStrings.map({
  //                    UnitDensity.value(forKey: $0)
  //                })
  ////                let aaa = toUnitCases(allStringCases: Density.allCases.toStrings)
  //                let bbb = v[itemIndex!]
  //                let ccc = bbb as! UnitDensity(
  ////                let lookupItem = toUnitCases(allStringCases: Density.allCases.toStrings)[itemIndex!] as! UnitDensity
  //                return ccc
  //            }
  //        }
  //
  //        return nil
  //    }
  
}
