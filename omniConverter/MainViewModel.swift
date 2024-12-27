//
//  MainViewModel.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import Foundation

class MainViewModel: ObservableObject {
  @Published var conversionType: ConversionType = .length
  @Published var one: Length = .millimeters
  @Published var two: Length = .inches
  @Published var oneValue: String = ""
  @Published var twoValue: String = ""
}
