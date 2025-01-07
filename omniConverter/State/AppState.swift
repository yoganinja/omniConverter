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
  var inputValue: String
}

class AppState: ObservableObject {
  @AppStorage("selectedConversionType") var selectedConversionTypeStored: ConversionType = .length
  @Published var selectedConversionType: ConversionType = .length
  @Published var selectedInputUnit: String = "Inches"
  @Published var selectedOutputUnit: String = "Millimeters"
  @Published var lastUsed: [ConversionType: InOutUnits] = [:] {
    didSet {
      saveData()
    }
  }
  
  private let persistenceKey = "lastUsedUnits"
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    loadData()
    
    // Initialize Published properties with the stored values
    selectedConversionType = selectedConversionTypeStored
    
    // Observe changes to Published properties and save them to UserDefaults
    $selectedConversionType
      .sink { [weak self] newValue in self?.selectedConversionTypeStored = newValue }
      .store(in: &cancellables)
  }
  
  // Save data to UserDefaults
  private func saveData() {
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(lastUsed)
      UserDefaults.standard.set(data, forKey: persistenceKey)
    } catch {
      print("Failed to save data: \(error)")
    }
  }
  
  // Load data from UserDefaults
  private func loadData() {
    guard let data = UserDefaults.standard.data(forKey: persistenceKey) else { return }
    do {
      let decoder = JSONDecoder()
      lastUsed = try decoder.decode([ConversionType: InOutUnits].self, from: data)
    } catch {
      print("Failed to load data: \(error)")
    }
  }
}
