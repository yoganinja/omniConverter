//
//  MainViewModel.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import Foundation

class MainViewModel: ObservableObject {
  @Published var inputValue: String = "0"
  @Published var outputValue: String = "0"
  @Published var selectedConversionType: ConversionType = .length
  @Published var selectedInputUnit: String = "Inches"
  @Published var selectedOutputUnit: String = "Millimeters"
  @Published var isConversionTypeSelectorOpen: Bool = false
  @Published var isInputUnitSelectorOpen: Bool = false
  @Published var isOutputUnitSelectorOpen: Bool = false
  @Published var searchQuery: String = ""
}
