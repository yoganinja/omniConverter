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
            
            ConversionTypePicker(
              isOpen: $vm.isConversionTypeSelectorOpen,
              selectedConversionType: $vm.selectedConversionType
            ) { type in
              vm.updateConversionType(to: type)
            }
            .padding()
            
          }
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top)
        
        ZStack {
          VStack {
            // Input Section
            HStack {
              VStack(alignment: .leading) {
                
                UnitSelector(
                  isOpen: $vm.isInputUnitSelectorOpen,
                  selectedConversionType: vm.selectedConversionType,
                  selectedUnit: $vm.selectedInputUnit,
                  units: vm.availableUnits
                ) { unit in
                  vm.selectedInputUnit = unit
                }
                .padding()
                
                HStack(alignment: .lastTextBaseline) {
                  Text(vm.inputValue)
                    .font(.largeTitle)
                    .padding(.vertical, 4)
//                  TextField("0", text: $vm.inputValue)
//                    .font(.largeTitle)
//                    .padding(.vertical, 4)
//                    .keyboardType(.decimalPad)
//                    .disabled(true)
                  Text("\(vm.selectedInputUnit.unit(for: vm.selectedConversionType)?.symbol ?? "")")
                    .font(.subheadline)
                }
                .foregroundColor(.red)
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
                
                UnitSelector(
                  isOpen: $vm.isOutputUnitSelectorOpen,
                  selectedConversionType: vm.selectedConversionType,
                  selectedUnit: $vm.selectedOutputUnit,
                  units: vm.availableUnits
                ) { unit in
                  vm.selectedOutputUnit = unit
                }
                .padding()
                
                HStack(alignment: .lastTextBaseline) {
                  Text(vm.outputValue)
                    .font(.largeTitle)
                    .padding(.vertical, 4)
                  Text("\(vm.selectedOutputUnit.unit(for: vm.selectedConversionType)?.symbol ?? "")")
                    .font(.subheadline)
                }
                .foregroundColor(.red)
              }
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
            SwapButton {
              vm.swapUnits()
            }
            .padding()
          }
          .padding()
        }
        
        Spacer()
        NumericKeyboard { key in
          vm.handleKeyPress(key)
        }
        Spacer()
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
}

//#Preview {
//  MainView(vm: MainViewModel())
//}
