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
  @State var selection: String = "Juan"
  
  var body: some View {
    NavigationStack {
      VStack {
        // Conversion Type Section
        HStack {
          ValuePicker(
            title: {
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
                  .padding(.vertical, 40)
              }
              .padding(.vertical, 8)
            },
            selection: $vm.selectedConversionType,
            isConversionTypeSelectorOpen: $vm.isConversionTypeSelectorOpen
          ) {
            ForEach(ConversionType.allCases, id: \.self) { name in
              Text(verbatim: name.id)
                .pickerTag(name)
            }
          }
          .onChange(of: vm.selectedConversionType) {_ in
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
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
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
              ValuePicker(
                title: {
                  VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                      Text("\(vm.selectedInputUnit) (\(vm.selectedInputUnit.unit(for: vm.selectedConversionType)?.symbol ?? ""))")
                      Spacer()
                      Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                      //          .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    
                    HStack(alignment: .lastTextBaseline) {
                      Text(vm.inputValue)
                        .font(.largeTitle)
                        .padding(.vertical, 4)
                      Text("\(vm.selectedInputUnit.unit(for: vm.selectedConversionType)?.symbol ?? "")")
                        .font(.subheadline)
                    }
                    .foregroundColor(.red)
                  }
                },
                selection: $vm.selectedInputUnit,
                isConversionTypeSelectorOpen: $vm.isConversionTypeSelectorOpen
              ) {
                ForEach(vm.selectedConversionType.unitTypeNames, id: \.self) { name in
                  Text(verbatim: name)
                    .pickerTag(name)
                }
              }
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top)
            
            
            // Output Section
            HStack {
              ValuePicker(
                title: {
                  VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                      Text("\(vm.selectedOutputUnit) (\(vm.selectedOutputUnit.unit(for: vm.selectedConversionType)?.symbol ?? ""))")
                      Spacer()
                      Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                      //          .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    
                    HStack(alignment: .lastTextBaseline) {
                      Text(vm.outputValue)
                        .font(.largeTitle)
                        .padding(.vertical, 4)
                      Text("\(vm.selectedOutputUnit.unit(for: vm.selectedConversionType)?.symbol ?? "")")
                        .font(.subheadline)
                    }
                    .foregroundColor(.red)
                  }
                },
                selection: $vm.selectedOutputUnit,
                isConversionTypeSelectorOpen: $vm.isConversionTypeSelectorOpen
              ) {
                ForEach(vm.selectedConversionType.unitTypeNames, id: \.self) { name in
                  Text(verbatim: name)
                    .pickerTag(name)
                }
              }
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top)
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
      .background(Color.red.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
  }
}

//#Preview {
//  MainView(vm: MainViewModel())
//}
extension Binding where Value == [Bool] {
  static func combine(_ bindings: Binding<Bool>...) -> Binding<[Bool]> {
    Binding<[Bool]>(
      get: { bindings.map { $0.wrappedValue } },
      set: { newValue in
        for (index, binding) in bindings.enumerated() {
          if index < newValue.count {
            binding.wrappedValue = newValue[index]
          }
        }
      }
    )
  }
}
