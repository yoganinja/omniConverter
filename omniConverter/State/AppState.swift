//
//  AppState.swift
//  omniConverter
//
//  Created by John Florian on 1/3/25.
//

import Combine
import SwiftUI

class AppState: ObservableObject {
  //MARK: Published properties
  @AppStorage("selectedConversionType") var selectedConversionTypeStored: ConversionType = .length
  @Published var selectedConversionType: ConversionType = .length
  @Published var selectedInputUnit: String = "Inches"
  @Published var selectedOutputUnit: String = "Millimeters"
  @Published var lastUsed: [ConversionType: InOutUnits] = [:] {
    didSet {
      saveData()
    }
  }
  @Published var favoriteConversions: [FavoriteConversion] = [] {
    didSet {
      saveData()
    }
  }
//  @Published var isFavorite: Bool = false
  
  //MARK: Private properties
  private let persistenceKey = "lastUsedUnits"
  private let persistedFavoritesKey = "favoriteConversions"
  private var cancellables = Set<AnyCancellable>()
  
  //MARK: Constructors
  init() {
    loadData()
    loadFavorites()
    
    // Initialize Published properties with the stored values
    selectedConversionType = selectedConversionTypeStored
    
    // Observe changes to Published properties and save them to UserDefaults
    $selectedConversionType
      .sink { [weak self] newValue in self?.selectedConversionTypeStored = newValue }
      .store(in: &cancellables)
  }
  
  //MARK: Persistence
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
  
  //MARK: Favorites
  func addFavorite() {
    let newFavorite = FavoriteConversion(conversionType: selectedConversionType, inputUnit: selectedInputUnit, outputUnit: selectedOutputUnit)
    if !favoriteConversions.contains(newFavorite) {
      favoriteConversions.append(newFavorite)
    }
    saveFavorites()
  }
  
  func removeFavorite() {
    let notFavorite = FavoriteConversion(conversionType: selectedConversionType, inputUnit: selectedInputUnit, outputUnit: selectedOutputUnit)
    removeFavorite(favoriteConversion: notFavorite)
  }
  
  func removeFavorite(favoriteConversion: FavoriteConversion) {
    favoriteConversions.removeAll { $0 == favoriteConversion }
    saveFavorites()
  }
  
  var isFavorite: Bool {
    let newFavorite = FavoriteConversion(conversionType: selectedConversionType, inputUnit: selectedInputUnit, outputUnit: selectedOutputUnit)
    return favoriteConversions.contains(newFavorite)
  }
  
//  func addFavorite() -> UUID {
//    let newFavorite = FavoriteConversion(conversionType: selectedConversionType, inputUnit: selectedInputUnit, outputUnit: selectedOutputUnit)
//    let newId = UUID()
//    favoriteConversions[newId] = newFavorite
//    saveFavorites()
//    
//    return newId
//  }
//  
//  func removeFavorite(id: UUID) {
//    if favoriteConversions[id] != nil {
//      favoriteConversions.removeValue(forKey: id)
//      saveFavorites()
//    }
//  }
  
  private func saveFavorites() {
    do {
      let data = try JSONEncoder().encode(favoriteConversions)
      UserDefaults.standard.set(data, forKey: persistedFavoritesKey)
    } catch {
      print("Failed to save favorites: \(error)")
    }
  }
  
  private func loadFavorites() {
    guard let data = UserDefaults.standard.data(forKey: persistedFavoritesKey) else { return }
    do {
      favoriteConversions = try JSONDecoder().decode([FavoriteConversion].self, from: data)
    } catch {
      print("Failed to load favorites: \(error)")
    }
  }
}
