//
//  InformationStorage.swift
//  omniConverter
//
//  Created by John Florian on 1/2/25.
//

import Foundation

enum InformationStorage: String, CaseIterable, Identifiable {
  case bytes = "Bytes"
  case bits = "Bits"
  case nibbles = "Nibbles"
  case yottabytes = "Yottabytes"
  case zettabytes = "Zettabytes"
  case exabytes = "Exabytes"
  case petabytes = "Petabytes"
  case terabytes = "Terabytes"
  case gigabytes = "Gigabytes"
  case megabytes = "Megabytes"
  case kilobytes = "Kilobytes"
  case yottabits = "Yottabits"
  case zettabits = "Zettabits"
  case exabits = "Exabits"
  case petabits = "Petabits"
  case terabits = "Terabits"
  case gigabits = "Gigabits"
  case megabits = "Megabits"
  case kilobits = "Kilobits"
  case yobibytes = "Yobibytes"
  case zebibytes = "Zebibytes"
  case exbibytes = "Exbibytes"
  case pebibytes = "Pebibytes"
  case tebibytes = "Tebibytes"
  case gibibytes = "Gibibytes"
  case mebibytes = "Mebibytes"
  case kibibytes = "Kibibytes"
  case yobibits = "Yobibits"
  case zebibits = "Zebibits"
  case exbibits = "Exbibits"
  case pebibits = "Pebibits"
  case tebibits = "Tebibits"
  case gibibits = "Gibibits"
  case mebibits = "Mebibits"
  case kibibits = "Kibibits"
  
  var id: String { self.rawValue }
  var symbol: String { InformationStorage.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitInformationStorage? {
    if let unit = UnitInformationStorage.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitInformationStorage, to: UnitInformationStorage) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitInformationStorage {
  static let allUnits: [String: UnitInformationStorage] = {
    InformationStorage.allCases.reduce(into: [String: UnitInformationStorage]()) { dict, type in
      switch type {
      case .bytes:
        dict[type.rawValue] = .bytes
      case .bits:
        dict[type.rawValue] = .bits
      case .nibbles:
        dict[type.rawValue] = .nibbles
      case .yottabytes:
        dict[type.rawValue] = .yottabytes
      case .zettabytes:
        dict[type.rawValue] = .zettabytes
      case .exabytes:
        dict[type.rawValue] = .exabytes
      case .petabytes:
        dict[type.rawValue] = .petabytes
      case .terabytes:
        dict[type.rawValue] = .terabytes
      case .gigabytes:
        dict[type.rawValue] = .gigabytes
      case .megabytes:
        dict[type.rawValue] = .megabytes
      case .kilobytes:
        dict[type.rawValue] = .kilobytes
      case .yottabits:
        dict[type.rawValue] = .yottabits
      case .zettabits:
        dict[type.rawValue] = .zettabits
      case .exabits:
        dict[type.rawValue] = .exabits
      case .petabits:
        dict[type.rawValue] = .petabits
      case .terabits:
        dict[type.rawValue] = .terabits
      case .gigabits:
        dict[type.rawValue] = .gigabits
      case .megabits:
        dict[type.rawValue] = .megabits
      case .kilobits:
        dict[type.rawValue] = .kilobits
      case .yobibytes:
        dict[type.rawValue] = .yobibytes
      case .zebibytes:
        dict[type.rawValue] = .zebibytes
      case .exbibytes:
        dict[type.rawValue] = .exbibytes
      case .pebibytes:
        dict[type.rawValue] = .pebibytes
      case .tebibytes:
        dict[type.rawValue] = .tebibytes
      case .gibibytes:
        dict[type.rawValue] = .gibibytes
      case .mebibytes:
        dict[type.rawValue] = .mebibytes
      case .kibibytes:
        dict[type.rawValue] = .kibibytes
      case .yobibits:
        dict[type.rawValue] = .yobibits
      case .zebibits:
        dict[type.rawValue] = .zebibits
      case .exbibits:
        dict[type.rawValue] = .exbibits
      case .pebibits:
        dict[type.rawValue] = .pebibits
      case .tebibits:
        dict[type.rawValue] = .tebibits
      case .gibibits:
        dict[type.rawValue] = .gibibits
      case .mebibits:
        dict[type.rawValue] = .mebibits
      case .kibibits:
        dict[type.rawValue] = .kibibits
      }
    }
  }()
  
    static let allCases: [UnitInformationStorage] =
    InformationStorage.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitInformationStorage? {
    if let v = UnitInformationStorage.value(forKey: self) {
      if let value = v as? UnitInformationStorage {
        return value
      }
    }
    
    return nil
  }
}

