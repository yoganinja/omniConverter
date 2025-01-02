//
//  Conversion.swift
//  omniConverter
//
//  Created by John Florian on 12/24/24.
//

import Foundation
import SwiftUICore

enum ConversionType: String, CaseIterable, Identifiable {
  case acceleration = "Acceleration"
  case angle = "Angle"
  case area = "Area"
  case density = "Density"
  case dispersion = "Dispersion"
  case duration = "Duration"
  case electricCharge = "Electric Charge"
  case electricCurrent = "Electric Current"
  case electricPotentialDifference = "Electric Potential Difference"
  case electricResistance = "Electric Resistance"
  case energy = "Energy"
  case frequency = "Frequency"
  case fuelEfficiency = "Fuel Efficiency"
  case illuminance = "Illuminance"
  case length = "Length"
  case mass = "Mass"
  case power = "Power"
  case pressure = "Pressure"
  case radiationDose = "Radiation Dose"
  case radioactivity = "Radioactivity"
  case speed = "Speed"
  case temperature = "Temperature"
  case volume = "Volume"
  
  var id: String { self.rawValue }
  
  // Map to the corresponding Dimension.Type
  var unitType: Dimension.Type {
    switch self {
    case .acceleration:
      return UnitAcceleration.self
    case .angle:
      return UnitAngle.self
    case .area:
      return UnitArea.self
    case .density:
      return UnitDensity.self
    case .dispersion:
      return UnitDispersion.self
    case .duration:
      return UnitDuration.self
    case .electricCharge:
      return UnitElectricCharge.self
    case .electricCurrent:
      return UnitElectricCurrent.self
    case .electricPotentialDifference:
      return UnitElectricPotentialDifference.self
    case .electricResistance:
      return UnitElectricResistance.self
    case .energy:
      return UnitEnergy.self
    case .frequency:
      return UnitFrequency.self
    case .fuelEfficiency:
      return UnitFuelEfficiency.self
    case .illuminance:
      return UnitIlluminance.self
    case .length:
      return UnitLength.self
    case .mass:
      return UnitMass.self
    case .power:
      return UnitPower.self
    case .pressure:
      return UnitPressure.self
    case .radiationDose:
      return UnitRadiationDose.self
    case .radioactivity:
      return UnitRadioactivity.self
    case .speed:
      return UnitSpeed.self
    case .temperature:
      return UnitTemperature.self
    case .volume:
      return UnitVolume.self
    }
  }
  
  var imageName: String {
    switch self {
    case .length:
      return "ruler"
    case .mass:
      return "scalemass"
    case .temperature:
      return "thermometer"
    case .acceleration:
      return "gauge"
    case .angle:
      return "angle"
    case .area:
      return "square.grid.2x2"
    case .density:
      return "cube.fill"
    case .dispersion:
      return "waveform.path.ecg"
    case .duration:
      return "clock"
    case .electricCharge:
      return "bolt.fill"
    case .electricCurrent:
      return "waveform.path"
    case .electricPotentialDifference:
      return "bolt.circle"
    case .electricResistance:
      return "waveform"
    case .energy:
      return "flame"
    case .frequency:
      return "antenna.radiowaves.left.and.right"
    case .fuelEfficiency:
      return "drop.fill"
    case .illuminance:
      return "lightbulb"
    case .power:
      return "powerplug.fill"
    case .pressure:
      return "gauge.badge.plus"
    case .radiationDose:
      return "radiowaves.left"
    case .radioactivity:
      return "radiowaves.right"
    case .speed:
      return "speedometer"
    case .volume:
      return "cube"
    }
  }
}

extension ConversionType {
  var unitTypeNames: [String] {
    switch self {
    case .acceleration:
      return Acceleration.allCases.names
    case .angle:
      return Angle.allCases.names
    case .area:
      return Area.allCases.names
    case .density:
      return Density.allCases.names
    case .dispersion:
      return Dispersion.allCases.names
    case .duration:
      return Duration.allCases.names
    case .electricCharge:
      return ElectricCharge.allCases.names
    case .electricCurrent:
      return ElectricCurrent.allCases.names
    case .electricPotentialDifference:
      return ElectricPotentialDifference.allCases.names
    case .electricResistance:
      return ElectricResistance.allCases.names
    case .energy:
      return Energy.allCases.names
    case .frequency:
      return Frequency.allCases.names
    case .fuelEfficiency:
      return FuelEfficiency.allCases.names
    case .illuminance:
      return Illuminance.allCases.names
    case .length:
      return Length.allCases.names
    case .mass:
      return Mass.allCases.names
    case .power:
      return Power.allCases.names
    case .pressure:
      return Pressure.allCases.names
    case .radiationDose:
      return RadiationDose.allCases.names
    case .radioactivity:
      return Radioactivity.allCases.names
    case .speed:
      return Speed.allCases.names
    case .temperature:
      return Temperature.allCases.names
    case .volume:
      return Volume.allCases.names
    }
  }
}

extension String {
  func unit(for conversionType: ConversionType) -> Dimension? {
    switch conversionType.unitType {
    case is UnitAcceleration.Type:
      return UnitAcceleration.allUnits[self]
    case is UnitAngle.Type:
      return UnitAngle.allUnits[self]
    case is UnitArea.Type:
      return UnitArea.allUnits[self]
    case is UnitDensity.Type:
      return UnitDensity.allUnits[self]
    case is UnitDispersion.Type:
      return UnitDispersion.allUnits[self]
    case is UnitDuration.Type:
      return UnitDuration.allUnits[self]
    case is UnitElectricCharge.Type:
      return UnitElectricCharge.allUnits[self]
    case is UnitElectricCurrent.Type:
      return UnitElectricCurrent.allUnits[self]
    case is UnitElectricPotentialDifference.Type:
      return UnitElectricPotentialDifference.allUnits[self]
    case is UnitElectricResistance.Type:
      return UnitElectricResistance.allUnits[self]
    case is UnitEnergy.Type:
      return UnitEnergy.allUnits[self]
    case is UnitFrequency.Type:
      return UnitFrequency.allUnits[self]
    case is UnitFuelEfficiency.Type:
      return UnitFuelEfficiency.allUnits[self]
    case is UnitIlluminance.Type:
      return UnitIlluminance.allUnits[self]
    case is UnitLength.Type:
      return UnitLength.allUnits[self]
    case is UnitMass.Type:
      return UnitMass.allUnits[self]
    case is UnitPower.Type:
      return UnitPower.allUnits[self]
    case is UnitPressure.Type:
      return UnitPressure.allUnits[self]
    case is UnitRadiationDose.Type:
      return UnitRadiationDose.allUnits[self]
    case is UnitRadioactivity.Type:
      return UnitRadioactivity.allUnits[self]
    case is UnitSpeed.Type:
      return UnitSpeed.allUnits[self]
    case is UnitTemperature.Type:
      return UnitTemperature.allUnits[self]
    case is UnitVolume.Type:
      return UnitVolume.allUnits[self]
    default:
      return nil
    }
  }
}
