//
//  MainView.swift
//  omniConverter
//
//  Created by John Florian on 12/20/24.
//

import SwiftUI

//struct PlayView: View {
//  let types = ConversionType.allCases
//  let unitNames = ConversionType.length.unitTypeNames
////  let units = Length.allUnitCases
//  @State private var selectedConversionTypeUnits: [Unit]// = ConversionType.length.allUnitCases
//  
//  var body: some View {
////    ForEach(types, id: \.self) { type in
////      List {
////        ForEach(type.unitTypeNames) { unit in
////          Text("\(unit.id)")
////            .padding()
////        }
////      }
////    }
//    
//    ForEach(types, id: \.self) { type in
////      Text(type.id.unit?.symbol ?? "")
////      Text(type.unitType.debugDescription())
//      
//      List {
//        ForEach(type.unitTypeNames, id: \.self) { unit in
//          Text(unit)
//            .padding()
//        }
//      }
//    }
//    
//    List {
//      ForEach(unitNames, id: \.self) { unit in
//        Text(unit)
//          .padding()
//      }
//    }
//  }
//}

struct MainView: View {
  @EnvironmentObject var appState: AppState
  @StateObject var vm: MainViewModel
  
  @State var favCon: FavoriteConversion? = FavoriteConversion(conversionType: .length, inputUnit: "Meters", outputUnit: "Feet")
  @State var isFavoritesOpen: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        //MARK: Conversion Type Section
        HStack {
          ValuePicker(
            title: {
              HStack(alignment: .center) {
                Image(systemName: appState.selectedConversionType.imageName)
                  .resizable()
                  .frame(width: 24, height: 24)
                  .padding(.vertical)
                Text(appState.selectedConversionType.id)
                  .font(.system(size: 32, weight: .bold))
                  .padding(.top, 16)
                  .padding(.bottom, 8)
                Spacer()
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 24, height: 24)
                  .padding(.vertical, 40)
              }
              .padding(.vertical, 8)
            },
            selection: $appState.selectedConversionType,
            isSelectorOpen: $vm.isConversionTypeSelectorOpen
          ) {
            ForEach(ConversionType.allCases, id: \.self) { name in
              Text(verbatim: name.id)
                .pickerTag(name)
            }
          }
          .onChange(of: appState.selectedConversionType) {_ in
            vm.updateConversionType()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top)
        
        //MARK: Units Section
        ZStack {
          VStack {
            
            //MARK: Input Section
            HStack {
              ValuePicker(
                title: {
                  VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                      Text("\(appState.selectedInputUnit) (\(appState.selectedInputUnit.unit(for: appState.selectedConversionType)?.symbol ?? ""))")
                      Spacer()
                      Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                      //          .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    
                    HStack(alignment: .lastTextBaseline) {
                      Text(vm.inputValue)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5) // Adjust this factor as needed
                        .lineLimit(1) // Ensure single-line display
                        .padding(.vertical, 4)
                      Text("\(appState.selectedInputUnit.unit(for: appState.selectedConversionType)?.symbol ?? "")")
                        .font(.subheadline)
                    }
                    .foregroundColor(.red)
                  }
                },
                selection: $appState.selectedInputUnit,
                isSelectorOpen: $vm.isConversionTypeSelectorOpen
              ) {
                ForEach(appState.selectedConversionType.unitTypeNames, id: \.self) { name in
                  Text(verbatim: "\(name) (\(name.unit(for: appState.selectedConversionType)?.symbol ?? ""))")
                    .pickerTag(name)
                }
              }
              .onChange(of: appState.selectedInputUnit) {_ in
                vm.updateInputUnit()
              }
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal)
            .padding(.top)
            
            //MARK: Output Section
            HStack {
              ValuePicker(
                title: {
                  VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                      Text("\(appState.selectedOutputUnit) (\(appState.selectedOutputUnit.unit(for: appState.selectedConversionType)?.symbol ?? ""))")
                      Spacer()
                      Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                      //          .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    
                    HStack(alignment: .lastTextBaseline) {
                      Text(vm.outputValue)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5) // Adjust this factor as needed
                        .lineLimit(1) // Ensure single-line display
                        .padding(.vertical, 4)
                      Text("\(appState.selectedOutputUnit.unit(for: appState.selectedConversionType)?.symbol ?? "")")
                        .font(.subheadline)
                    }
                    .foregroundColor(.red)
                  }
                },
                selection: $appState.selectedOutputUnit,
                isSelectorOpen: $vm.isConversionTypeSelectorOpen
              ) {
                ForEach(appState.selectedConversionType.unitTypeNames, id: \.self) { name in
                  Text(verbatim: "\(name) (\(name.unit(for: appState.selectedConversionType)?.symbol ?? ""))")
                    .pickerTag(name)
                }
              }
              .onChange(of: appState.selectedOutputUnit) {_ in
                vm.updateOutputUnit()
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
          
          //MARK: Unit Switcher
          HStack {
            Spacer()
            SwapButton {
              vm.swapUnits()
            }
            .padding()
          }
          .padding()
        }
        
        //MARK: Keyboard
        NumericKeyboard { key in
          vm.handleKeyPress(key)
        }
        Spacer()
      }
      .background(Color.red.opacity(0.1).edgesIgnoringSafeArea(.all))
      .onAppear {
        vm.updateConversionType()
      }
    }
  }
}

//#Preview {
//  MainView(vm: MainViewModel())
//}
