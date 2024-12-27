//
//  MainView.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import SwiftUI

struct MainView: View {
  @StateObject var vm: MainViewModel
  
  var body: some View {
    VStack {
      Picker("", selection: $vm.conversionType) {
        ForEach(ConversionType.allCases) { type in
          HStack {
            Image(systemName: type.imageName)
            Text(type.id)
          }
          .tag(type)
        }
      }
      .pickerStyle(.menu)
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(8)
      
      Picker("", selection: $vm.one) {
        ForEach(ConversionUnit.allCases) { type in
          HStack {
            Image(systemName: "bolt")
            Text(type.id)
            TextField("one", text: $vm.oneValue)
          }
          .tag(type)
        }
      }
      .pickerStyle(.menu)
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color.red.opacity(0.1))
      .cornerRadius(8)
      
      Picker("", selection: $vm.two) {
        ForEach(ConversionUnit.allCases) { type in
          HStack {
            Image(systemName: "bolt.fill")
            Text(type.id)
            TextField("two", text: $vm.twoValue)
          }
          .tag(type)
        }
      }
      .pickerStyle(.menu)
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color.red.opacity(0.1))
      .cornerRadius(8)
      
      CalculatorView()
    }
    .padding()
  }
}

enum ConversionUnit: String, CaseIterable, Identifiable {
  case millimeter = "Millimeter"
  case inch = "Inch"

  var id: String { self.rawValue }
  var symbol: String {
    return switch self {
    case .millimeter: "mm"
    case .inch: "in"
    }
  }
}

#Preview {
  MainView(vm: MainViewModel())
}
