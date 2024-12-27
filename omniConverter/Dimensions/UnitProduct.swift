//
//  UnitProduct.swift
//  omniConverter
//
//  Created by John Florian on 8/4/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

/// Describes the relation Self = Factor1 * Factor2.
protocol UnitProduct {
  associatedtype Factor1: Dimension
  associatedtype Factor2: Dimension
  associatedtype Product: Dimension // is always == Self
  
  static func defaultUnitMapping() -> (Factor1, Factor2, Product)
}

/// UnitProduct.Product = Factor1 * Factor2
func * <UnitType: UnitProduct> (lhs: Measurement<UnitType.Factor1>, rhs: Measurement<UnitType.Factor2>)
-> Measurement<UnitType> where UnitType == UnitType.Product {
  let (leftUnit, rightUnit, resultUnit) = UnitType.defaultUnitMapping()
  let quantity = lhs.converted(to: leftUnit).value
  * rhs.converted(to: rightUnit).value
  return Measurement(value: quantity, unit: resultUnit)
}

/// UnitProduct.Product = Factor2 * Factor1
func * <UnitType: UnitProduct>(lhs: Measurement<UnitType.Factor2>, rhs: Measurement<UnitType.Factor1>)
-> Measurement<UnitType> where UnitType == UnitType.Product {
  return rhs * lhs
}

/// UnitProduct / Factor1 = Factor2
func / <UnitType: UnitProduct>(lhs: Measurement<UnitType>, rhs: Measurement<UnitType.Factor1>)
-> Measurement<UnitType.Factor2> where UnitType == UnitType.Product {
  let (rightUnit, resultUnit, leftUnit) = UnitType.defaultUnitMapping()
  let quantity = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
  return Measurement(value: quantity, unit: resultUnit)
}

/// UnitProduct / Factor2 = Factor1
func / <UnitType: UnitProduct>(lhs: Measurement<UnitType>, rhs: Measurement<UnitType.Factor2>)
-> Measurement<UnitType.Factor1> where UnitType == UnitType.Product {
  let (resultUnit, rightUnit, leftUnit) = UnitType.defaultUnitMapping()
  let quantity = lhs.converted(to: leftUnit).value / rhs.converted(to: rightUnit).value
  return Measurement(value: quantity, unit: resultUnit)
}
