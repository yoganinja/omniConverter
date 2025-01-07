//
//  AppState.swift
//  omniConverter
//
//  Created by John Florian on 1/3/25.
//

import Combine
import SwiftUI

struct InOutUnits: Codable {
  var inputUnit: String
  var outputUnit: String
}

class AppState: ObservableObject {
  @AppStorage("selectedConversionType") var selectedConversionTypeStored: ConversionType = .length
  @AppStorage("selectedInputUnit") var selectedInputUnitStored: String = "Inches"
  @AppStorage("selectedOutputUnit") var selectedOutputUnitStored: String = "Millimeters"
  @Published var selectedConversionType: ConversionType = .length
  @Published var selectedInputUnit: String = "Inches"
  @Published var selectedOutputUnit: String = "Millimeters"
  @Published var lastUsed: [ConversionType: InOutUnits] = [.angle: InOutUnits(inputUnit: "Degrees", outputUnit: "Radians")]
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    // Initialize Published properties with the stored values
    selectedConversionType = selectedConversionTypeStored
    selectedInputUnit = selectedInputUnitStored
    selectedOutputUnit = selectedOutputUnitStored
    
    // Observe changes to Published properties and save them to UserDefaults
    $selectedConversionType
      .sink { [weak self] newValue in self?.selectedConversionTypeStored = newValue }
      .store(in: &cancellables)
    
    $selectedInputUnit
      .sink { [weak self] newValue in self?.selectedInputUnitStored = newValue }
      .store(in: &cancellables)
    
    $selectedOutputUnit
      .sink { [weak self] newValue in self?.selectedOutputUnitStored = newValue }
      .store(in: &cancellables)
  }
}
