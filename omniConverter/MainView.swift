//
//  MainView.swift
//  omniConverter
//
//  Created by John Florian on 12/20/24.
//

import SwiftUI

struct PlayView: View {
  let types = ConversionType.allCases
  let unitNames = ConversionType.length.unitTypeNames
  let units = Length.allUnitCases
  @State private var selectedConversionTypeUnits: [Unit]// = ConversionType.length.allUnitCases
  
  var body: some View {
//    ForEach(types, id: \.self) { type in
//      List {
//        ForEach(type.unitTypeNames) { unit in
//          Text("\(unit.id)")
//            .padding()
//        }
//      }
//    }
    
    ForEach(types, id: \.self) { type in
//      Text(type.id.unit?.symbol ?? "")
//      Text(type.unitType.debugDescription())
      
      List {
        ForEach(type.unitTypeNames, id: \.self) { unit in
          Text(unit)
            .padding()
        }
      }
    }
    
    List {
      ForEach(unitNames, id: \.self) { unit in
        Text(unit)
          .padding()
      }
    }
  }
}

struct MainView: View {
  @StateObject var vm: MainViewModel
  
  var body: some View {
    ZStack {
      VStack {
        // Conversion Type Section
        HStack {
          VStack(alignment: .leading) {
            Button(action: {
              vm.isConversionTypeSelectorOpen.toggle()
            }) {
              HStack(alignment: .center) {
                Image(systemName: vm.selectedConversionType.imageName)
                  .resizable()
                  .frame(width: 24, height: 24)
                  .padding(.vertical)
                Text(vm.selectedConversionType.id)
                  .font(.system(size: 32, weight: .bold))
                  .padding(.top, 16)
                  .padding(.bottom, 8)
                
                Spacer()
                Image(systemName: "chevron.down")
                  .resizable()
                  .frame(width: 24, height: 24)
                  .padding(.vertical)
              }
            }
            .padding(.vertical, 8)
            
          }
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top, 8)
        
        ZStack {
          VStack {
            // Input Section
            HStack {
              VStack(alignment: .leading) {
                Button(action: {
                  vm.isInputUnitSelectorOpen.toggle()
                }) {
                  HStack {
                    Text("\(vm.selectedInputUnit) (\(vm.selectedInputUnit.unit(for: vm.selectedConversionType)?.symbol ?? ""))")
//                      .font(.caption)
                    Spacer()
                    Image(systemName: "chevron.down")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .padding(.top)
                      .foregroundColor(.gray)
                  }
                }
                .padding(.vertical, 8)
                
                TextField("0", text: $vm.inputValue)
                  .font(.largeTitle)
                  .keyboardType(.decimalPad)
                  .padding(.vertical, 4)
                  .disabled(true)
              }
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top)
            
            // Output Section
            HStack {
              VStack(alignment: .leading) {
                Button(action: {
                  vm.isOutputUnitSelectorOpen.toggle()
                }) {
                  HStack {
                    Text("\(vm.selectedOutputUnit) (\(vm.selectedOutputUnit.unit(for: vm.selectedConversionType)?.symbol ?? ""))")
//                      .font(.caption)
                    Spacer()
                    Image(systemName: "chevron.down")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .padding(.top)
                      .foregroundColor(.gray)
                  }
                }
                .padding(.vertical, 8)
                
                Text(vm.outputValue)
                  .font(.largeTitle)
                  .padding(.vertical, 4)
              }
              Spacer()
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top, 8)
          }
          
          HStack {
            Spacer()
            
            Button(action: {
              // Swap input and output units
              let tempUnit = vm.selectedInputUnit
              vm.selectedInputUnit = vm.selectedOutputUnit
              vm.selectedOutputUnit = tempUnit
              
              let tempValue = vm.inputValue
              vm.inputValue = vm.outputValue
              vm.outputValue = tempValue
            }) {
              ZStack {
                Circle()
                  .fill(Color.gray.opacity(0.3)) // Background color for the circle
                  .frame(width: 50, height: 50) // Size of the circle
                
                Image(systemName: "arrow.up.arrow.down")
                  .resizable()
                  .frame(width: 24, height: 24)
                  .padding()
              }
            }
          }
          .padding()
        }
        
        Spacer()
        
        // Numeric Keyboard
        HStack {
          VStack {
            ForEach(["789C%", "456÷×", "123-+", ".0⌫±="], id: \.self) { row in
              HStack {
                ForEach(row.map { String($0) }, id: \.self) { key in
                  Button(action: {
                    handleKeyPress(key)
                  }) {
                    Text(key)
                      .font(.largeTitle)
                      .frame(maxWidth: .infinity, maxHeight: 64)
                      .background(Color.gray.opacity(0.3))
                      .cornerRadius(8)
                  }
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .padding(.bottom)
      }
      
      // Conversion Type Selector Modal
      if vm.isConversionTypeSelectorOpen {
        VStack {
          HStack {
            TextField("Search...", text: $vm.searchQuery)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
            Button("Close") {
              vm.isConversionTypeSelectorOpen = false
            }
            .padding(.trailing)
          }
          List {
            ForEach(ConversionType.allCases.filter {
              vm.searchQuery.isEmpty || $0.id.lowercased().contains(vm.searchQuery.lowercased())
            }, id: \.self) { type in
              Button(action: {
                if vm.isConversionTypeSelectorOpen {
                  vm.selectedConversionType = type
                  vm.isConversionTypeSelectorOpen = false
                  
                  // Automatically set the input and output units based on the selected conversion type
                  if let firstUnit = vm.selectedConversionType.unitTypeNames.map({$0}).first
                  {
                    vm.selectedInputUnit = "\(firstUnit)"
                  }
                  if let secondUnit = vm.selectedConversionType.unitTypeNames.dropFirst().first {
                    vm.selectedOutputUnit = "\(secondUnit)"
                  } else if let secondUnit = vm.selectedConversionType.unitTypeNames.map({$0}).first {
                    vm.selectedOutputUnit = "\(secondUnit)"
                  }
                  
                }
              }) {
                HStack {
                  Image(systemName: type.imageName)
                  Text(type.id)
                }
                .tag(type)
//                Text(type.id)
//                  .padding()
              }
            }
          }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding()
        .transition(.opacity)
        .zIndex(1)
      }
      
      // Unit Selector Modal
      if vm.isInputUnitSelectorOpen || vm.isOutputUnitSelectorOpen {
        VStack {
          HStack {
            TextField("Search...", text: $vm.searchQuery)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal)
            Button("Close") {
              vm.isInputUnitSelectorOpen = false
              vm.isOutputUnitSelectorOpen = false
            }
            .padding(.trailing)
          }
          List {
            ForEach(vm.selectedConversionType.unitTypeNames.filter {
              vm.searchQuery.isEmpty || $0.lowercased().contains(vm.searchQuery.lowercased())
            }, id: \.self) { unit in
              Button(action: {
                if vm.isInputUnitSelectorOpen {
                  vm.selectedInputUnit = unit
                  vm.isInputUnitSelectorOpen = false
                } else if vm.isOutputUnitSelectorOpen {
                  vm.selectedOutputUnit = unit
                  vm.isOutputUnitSelectorOpen = false
                }
              }) {
                Text(unit)
                  .padding()
              }
            }
          }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding()
        .transition(.opacity)
        .zIndex(1)
      }
    }
    .background(Color.red.opacity(0.1).edgesIgnoringSafeArea(.all))
  }
  
  // Handle keyboard key press logic
  private func handleKeyPress(_ key: String) {
    switch key {
    case "C":
      vm.inputValue = "0"
      vm.outputValue = "0"
    case "⌫":
      vm.inputValue = String(vm.inputValue.dropLast())
      if vm.inputValue.isEmpty { vm.inputValue = "0" }
    default:
      if vm.inputValue == "0" {
        vm.inputValue = key
      } else {
        vm.inputValue.append(key)
      }
    }
    calculateOutput()
  }
  
  // Convert the input value based on selected units
  private func calculateOutput() {
    guard let input = Double(vm.inputValue) else {
      vm.outputValue = "0"
      return
    }
    
    let conversionFactor: Double
    if vm.selectedInputUnit == "Inch" && vm.selectedOutputUnit == "Millimeter" {
      conversionFactor = 25.4
    } else if vm.selectedInputUnit == "Millimeter" && vm.selectedOutputUnit == "Inch" {
      conversionFactor = 0.0393701
    } else {
      conversionFactor = 1.0 // Handle similar units or extend logic for others
    }
    
    let result = input * conversionFactor
    vm.outputValue = String(format: "%.2f", result)
  }
}

//#Preview {
//  MainView()
//}
