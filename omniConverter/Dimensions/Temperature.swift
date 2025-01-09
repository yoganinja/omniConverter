//
//  Temperature.swift
//  omniConverter
//
//  Created by John Florian on 6/23/17.
//  Copyright © 2017 John Florian. All rights reserved.
//

import Foundation

enum Temperature: String, CaseIterable, Identifiable {
  case celsius = "Celsius"
  case fahrenheit = "Fahrenheit"
  case kelvin = "Kelvin"
  
  var id: String { self.rawValue }
  var symbol: String { Temperature.unit(from: self.rawValue)?.symbol ?? "" }
  
  /// Type-safe way of getting the unit from a string name
  static func unit(from name: String) -> UnitTemperature? {
    if let unit = UnitTemperature.allUnits[name] {
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
  
  static func convert(value: Double, from: UnitTemperature, to: UnitTemperature) -> Double {
    return Measurement(value: value, unit: from).converted(to: to).value
  }
}

extension UnitTemperature {
  static let allUnits: [String: UnitTemperature] = {
    Temperature.allCases.reduce(into: [String: UnitTemperature]()) { dict, type in
      switch type {
      case .celsius:
        dict[type.rawValue] = .celsius
      case .fahrenheit:
        dict[type.rawValue] = .fahrenheit
      case .kelvin:
        dict[type.rawValue] = .kelvin
      }
    }
  }()
  
  static let allCases: [UnitTemperature] =
  Temperature.allCases.compactMap { $0.id.toUnit }
}

extension String {
  fileprivate var toUnit: UnitTemperature? {
    if let v = UnitTemperature.value(forKey: self) {
      if let value = v as? UnitTemperature {
        return value
      }
    }
    
    return nil
  }
}

//public class Temperature: NSObject {
//    static func convert(value: Double, from: Temperature, to: Temperature) -> Double {
//        switch from {
//        case celcius:
//            switch to {
//            case fahrenheit:
//                return value * 9 / 5 + 32
//            case kelvin:
//                return value + 273.15
//            default:
//                return value
//            }
//        case fahrenheit:
//            switch to {
//            case celcius:
//                return (value - 32) * 5 / 9
//            case kelvin:
//                return (value - 32) * 5 / 9 + 273.15
//            default:
//                return value
//            }
//        case kelvin:
//            switch to {
//            case celcius:
//                return value - 273.15
//            case fahrenheit:
//                return (value - 273.15) * 9 / 5 + 32
//            default:
//                return value
//            }
//        default:
//            return value
//        }
//    }

//    public func fahrenheitToCelcius(ambientTemperature T: Double) -> Double {
//        // T(°C) = (T(°F) - 32) × 5/9
//        return (T - 32) * 5 / 9
//    }
//
//    public func celciusToKelvin(ambientTemperature T: Double) -> Double {
//        // T(°K) = T(°C) + 273.15
//        return T + 273.15
//    }
//
//    public func kelvinToFahrenheit(ambientTemperature T: Double) -> Double {
//        // T(°F) = (T(°K) - 273.15) × 9/5 + 32
//        return kelvinToCelcius(ambientTemperature: T) * 9 / 5 + 32
//    }
//
//    public func fahrenheitToKelvin(ambientTemperature T: Double) -> Double {
//        // T(°K) = (T(°F) - 32) × 5/9 + 273.15
//        return fahrenheitToCelcius(ambientTemperature: T) + 273.15
//    }
//
//    public func kelvinToCelcius(ambientTemperature T: Double) -> Double {
//        // T(°C) = T(°K) - 273.15
//        return T - 273.15
//    }
//
//    public func celciusToFahrenheit(ambientTemperature T: Double) -> Double {
//        // T(°F) = T(°C) × 9/5 + 32
//        return T * 9 / 5 + 32
//    }
//
//    func heatIndex8040(ambientTemperature T: Double, relativeHumidity R: Double) -> Double {
//        // HI = c1 + c2 * T + c3 * R + c4 * T * R + c5 * T^2 + c6 * R^2 + c7 * T^2 * R + c8 * T * R^2 + c9 * T^2 * R^2
//        let c1: Double = -42.379
//        let c2: Double = 2.04901523 * T
//        let c3: Double = 10.14333127 * R
//        let c4: Double = -0.22475541 * T * R
//        let c5: Double = -6.83783 * pow(10, -3) * pow(T, 2)
//        let c6: Double = -5.481717 * pow(10, -2) * pow(R, 2)
//        let c7: Double = 1.22874 * pow(10, -3) * pow(T, 2) * R
//        let c8: Double = 8.5282 * pow(10, -4) * T * pow(R, 2)
//        let c9: Double = -1.99 * pow(10, -6) * pow(T, 2) * pow(R, 2)
//
//        let HI: Double = c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8 + c9
//
//        return HI
//    }
//
//    func heatIndex70115080(ambientTemperature T: Double, relativeHumidity R: Double) -> Double {
//        // HI = c1 + c2 * T + c3 * R + c4 * T * R + c5 * T^2 + c6 * R^2 + c7 * T^2 * R + c8 * T * R^2 + c9 * T^2 * R^2
//        let c1: Double = 0.363445176
//        let c2: Double = 0.988622465 * T
//        let c3: Double = 4.777114035 * R
//        let c4: Double = -0.114037667 * T * R
//        let c5: Double = -0.000850208 * pow(T, 2)
//        let c6: Double = -0.020716198 * pow(R, 2)
//        let c7: Double = 0.000687678 * pow(T, 2) * R
//        let c8: Double = 0.000274954 * T * pow(R, 2)
//
//        let HI: Double = c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8
//
//        return HI
//    }
//
//    func heatIndex3(ambientTemperature T: Double, relativeHumidity R: Double) -> Double {
//        // HI = c1 + c2 * T + c3 * R + c4 * T * R + c5 * T^2 + c6 * R^2 + c7 * T^2 * R + c8 * T * R^2 + c9 * T^2 * R^2
//        let c1: Double = 16.923
//        let c2: Double = 0.185212 * T
//        let c3: Double = 5.37941 * R
//        let c4: Double = -0.100254 * T * R
//        let c5: Double = 9.41695 * pow(10, -3) * pow(T, 2)
//        let c6: Double = 7.28898 * pow(10, -3) * pow(R, 2)
//        let c7: Double = 3.45372 * pow(10, -4) * pow(T, 2) * R
//        let c8: Double = -8.14971 * pow(10, -4) * T * pow(R, 2)
//        let c9: Double = 1.02102 * pow(10, -5) * pow(T, 2) * pow(R, 2)
//        let c10: Double = -3.8646 * pow(10, -5) * pow(T, 3)
//        let c11: Double = 2.91583 * pow(10, -5) * pow(R, 3)
//        let c12: Double = 1.42721 * pow(10, -6) * pow(T, 3) * R
//        let c13: Double = 1.97483 * pow(10, -7) * T * pow(R, 3)
//        let c14: Double = -2.18429 * pow(10, -8) * pow(T, 3) * pow(R, 2)
//        let c15: Double = 8.43296 * pow(10, -10) * pow(T, 2) * pow(R, 3)
//        let c16: Double = -4.81975 * pow(10, -11) * pow(T, 3) * pow(R, 3)
//
//        let HI: Double = c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8 + c9 + c10 + c11 + c12 + c13 + c14 + c15 + c16
//
//        return HI
//    }
//
//    func apparentTemperature(ambientTemperature T: Double,
//                             relativeHumidity R: Double) -> Double {
//        //   WBGT = 0.567 × Ta + 0.393 × e + 3.94
//        // where:
//        //   Ta = Dry bulb temperature (°C)
//        //   e  = Water vapour pressure (hPa) [humidity]
//        // The vapour pressure can be calculated from the temperature and relative humidity using the equation:
//        //   e  = rh / 100 × 6.105 × exp ( 17.27 × Ta / ( 237.7 + Ta ) )
//        // where:
//        //   rh = Relative Humidity [%]
//
//        let Tc = fahrenheitToCelcius(ambientTemperature: T)
//        let e: Double = waterVaporPressure(ambientTemperature: Tc, relativeHumidity: R)
//        let WBGT: Double = 0.567 * Tc + 0.393 * e + 3.94
//
//        return celciusToFahrenheit(ambientTemperature: WBGT)
//    }
//
//    func apparentTemperature(ambientTemperature T: Double,
//                             relativeHumidity rh: Double,
//                             windSpeed ws: Double) -> Double {
//        // AT = Ta + 0.33×e − 0.70×ws − 4.00
//        // where:
//        //   Ta = Dry bulb temperature (°C)
//        //   e  = Water vapour pressure (hPa) [humidity]
//        //   ws = Wind speed (m/s) at an elevation of 10 meters
//        // The vapour pressure can be calculated from the temperature and relative humidity using the equation:
//        //   e  = rh / 100 × 6.105 × exp ( 17.27 × Ta / ( 237.7 + Ta ) )
//        // where:
//        //   rh = Relative Humidity [%]
//
//        let Tc = fahrenheitToCelcius(ambientTemperature: T)
//        let e: Double = waterVaporPressure(ambientTemperature: Tc, relativeHumidity: rh)
//        let AT: Double = Tc + 0.33 * e - 0.70 * ws - 4.00
//
//        return celciusToFahrenheit(ambientTemperature: AT)
//    }
//
//    public func apparentTemperature(ambientTemperature T: Double,
//                                    relativeHumidity rh: Double,
//                                    windSpeed ws: Double,
//                                    radiation Q: Double) -> Double {
//        //   AT = Ta + 0.348×e − 0.70×ws + 0.70×Q/(ws + 10) − 4.25
//        // where:
//        //   Ta = Dry bulb temperature (°C)
//        //   e  = Water vapour pressure (hPa) [humidity]
//        //   ws = Wind speed (m/s) at an elevation of 10 meters
//        //   Q  = Net radiation absorbed per unit area of body surface (w/m2)
//        // The vapour pressure can be calculated from the temperature and relative humidity using the equation:
//        //   e  = rh / 100 × 6.105 × exp ( 17.27 × Ta / ( 237.7 + Ta ) )
//        // where:
//        //   rh = Relative Humidity [%]
//
//        let Tc = fahrenheitToCelcius(ambientTemperature: T)
//        let e: Double = waterVaporPressure(ambientTemperature: Tc, relativeHumidity: rh)
//        let AT: Double = Tc + 0.348 * e - 0.70 * ws + 0.70 * Q/(ws + 10) - 4.25
//
//        return celciusToFahrenheit(ambientTemperature: AT)
//    }
//
//    private func waterVaporPressure(ambientTemperature Ta: Double,
//                                    relativeHumidity rh: Double) -> Double {
//        //   e  = rh / 100 × 6.105 × exp ( ( 17.27 × Ta ) / ( 237.7 + Ta ) )
//        // where:
//        //   rh = Relative Humidity [%]
//
//        let e: Double = (rh / 100) * 6.105 * exp((17.27 * Ta) / (237.7 * Ta))
//
//        return e
//    }
//
//    func windChill() {
//
//    }
//}

