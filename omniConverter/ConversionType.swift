//
//  Conversion.swift
//  omniConverter
//
//  Created by John Florian on 12/24/24.
//

import Foundation
import SwiftUICore

enum ConversionType: String, CaseIterable, Identifiable, Codable {
  case acceleration = "Acceleration"
  case angle = "Angle"
  case area = "Area"
  case concentrationMass = "Concentration Mass"
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
  case informationStorage = "Information Storage"
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
    case .concentrationMass:
      return UnitConcentrationMass.self
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
    case .informationStorage:
      return UnitInformationStorage.self
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
    case .acceleration:
      return "gauge"
    case .angle:
      return "angle"
    case .area:
      return "square.grid.2x2"
    case .concentrationMass:
      return "cube.fill"
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
    case .informationStorage:
      return "swiftdata"
    case .length:
      return "ruler"
    case .mass:
      return "scalemass"
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
    case .temperature:
      return "thermometer"
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
    case .concentrationMass:
      return ConcentrationMass.allCases.names
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
    case .informationStorage:
      return InformationStorage.allCases.names
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
  
  var unitTypeSymbols: [String] {
    switch self {
    case .acceleration:
      return Acceleration.allCases.compactMap { $0.symbol }
    case .angle:
      return Angle.allCases.compactMap { $0.symbol }
    case .area:
      return Area.allCases.compactMap { $0.symbol }
    case .concentrationMass:
      return ConcentrationMass.allCases.compactMap { $0.symbol }
    case .density:
      return Density.allCases.compactMap { $0.symbol }
    case .dispersion:
      return Dispersion.allCases.compactMap { $0.symbol }
    case .duration:
      return Duration.allCases.compactMap { $0.symbol }
    case .electricCharge:
      return ElectricCharge.allCases.compactMap { $0.symbol }
    case .electricCurrent:
      return ElectricCurrent.allCases.compactMap { $0.symbol }
    case .electricPotentialDifference:
      return ElectricPotentialDifference.allCases.compactMap { $0.symbol }
    case .electricResistance:
      return ElectricResistance.allCases.compactMap { $0.symbol }
    case .energy:
      return Energy.allCases.compactMap { $0.symbol }
    case .frequency:
      return Frequency.allCases.compactMap { $0.symbol }
    case .fuelEfficiency:
      return FuelEfficiency.allCases.compactMap { $0.symbol }
    case .illuminance:
      return Illuminance.allCases.compactMap { $0.symbol }
    case .informationStorage:
      return InformationStorage.allCases.compactMap { $0.symbol }
    case .length:
      return Length.allCases.compactMap { $0.symbol }
    case .mass:
      return Mass.allCases.compactMap { $0.symbol }
    case .power:
      return Power.allCases.compactMap { $0.symbol }
    case .pressure:
      return Pressure.allCases.compactMap { $0.symbol }
    case .radiationDose:
      return RadiationDose.allCases.compactMap { $0.symbol }
    case .radioactivity:
      return Radioactivity.allCases.compactMap { $0.symbol }
    case .speed:
      return Speed.allCases.compactMap { $0.symbol }
    case .temperature:
      return Temperature.allCases.compactMap { $0.symbol }
    case .volume:
      return Volume.allCases.compactMap { $0.symbol }
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
    case is UnitConcentrationMass.Type:
      return UnitConcentrationMass.allUnits[self]
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
    case is UnitInformationStorage.Type:
      return UnitInformationStorage.allUnits[self]
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
