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
  
  /// Array of Unit representations of all enum cases
  static var allUnitCases: [UnitRadiationDose] {
    //        get {
    //            return toUnitCases(allStringCases: allCases.toStrings)
    //        }
    get {
      var collection: [UnitRadiationDose] = []
      for item in allCases.toStrings {
        if let value: UnitRadiationDose = UnitRadiationDose.getValue(forKey: item)  {
          collection.append(value)
        }
      }
      
      return collection
      //            return allCases.toStrings.map({
      //                UnitRadiationDose.getValue(forKey: $0)
      //            }) as! [UnitRadiationDose]
      //            return toUnitCases(allStringCases: allCases.toStrings)
    }
  }
  
  //    func toUnitCases<T: Dimension>(allStringCases: [String]) -> [T] {
  //        return allStringCases.map({
  //            T.value(forKey: $0)
  //        }) as! [T]
  //
  //        //    var collection: [T] = []
  //        //    for item in allStringCases {
  //        //        if let value = T.value(forKey: item) as? T {
  //        //            collection.append(value)
  //        //        }
  //        //    }
  //        //
  //        //    return collection
  //    }
  
  /// Unit representation of a case
  var toUnit: UnitRadiationDose? {
    get {
      if let _ = RadiationDose.allCases.firstIndex(of: self) {
        return self.rawValue.toUnit
      }
      
      return nil
    }
  }
  
  /// String representation of the enum case
  var toString: String {
    get {
      return String(describing: self)
    }
  }
  
  static func name(from stringName: String) -> UnitRadiationDose? {
    for item in allCases {
      if String(describing: item).stripSpaces.lowercased() == stringName.stripSpaces.lowercased() {
        let itemIndex = allCases.firstIndex(of: item)
        let lookupItem = allUnitCases[itemIndex!]
        return lookupItem
      }
    }
    
    return nil
  }
  
  static func convert(value: Double, from stringFrom: String, to stringTo: String) -> Double {
    let from = self.name(from: stringFrom)
    let to = self.name(from: stringTo)
    
    let result = self.convert(value: value, from: from!, to: to!)
    
    return result
  }
  
  static func convert(value: Double, from: UnitRadiationDose, to: UnitRadiationDose) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
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

extension UnitRadiationDose {
  static let allUnits: [String: UnitRadiationDose] = [
    "Bit": .bit,
    "Centigray": .centigray,
    "Gray": .gray,
    "Microgray": .microgray,
    "Microrem": .microrem,
    "Microsievert": .microsievert,
    "Milligray": .milligray,
    "Millirem": .millirem,
    "Millisievert": .millisievert,
    "Rad": .rad,
    "Rem": .rem,
    "Sievert": .sievert
  ]
}

extension String {
  fileprivate var toUnit: UnitRadiationDose? {
    //        let unitRadiationDose = UnitRadiationDose()
    
    let vv: UnitRadiationDose = UnitRadiationDose.getValue(forKey: self)
    
    return vv
    
    
    if let v = UnitRadiationDose.value(forKey: self) {
      if let value = v as? UnitRadiationDose {
        return value
      }
    }
    
    return nil
  }
}
