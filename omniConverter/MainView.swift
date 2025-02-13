//
//  MainView.swift
//  omniConverter
//
//  Created by John Florian on 12/20/24.
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var appState: AppState
  @StateObject var vm: MainViewModel
  
  @State var isFavoritesOpen: Bool = false
  
  @State private var searchText: String = ""
  @State private var suggestions: [Suggestion] = []
  @State private var isSearchOpen: Bool = false
  
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
                Text(appState.selectedConversionType.id)
                  .font(.system(size: 32, weight: .bold))
                Spacer()
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 24, height: 24)
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
        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: UIScreen.main.bounds.height * 0.15)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top, 5)
        
//        Spacer()
        
        //MARK: Units Section
        ZStack {
          VStack {
            //MARK: Input Section
            UnitPickerView(
              title: "\(appState.selectedInputUnit)",
              value: vm.inputValue,
              unitSymbol: appState.selectedInputUnit.unit(for: appState.selectedConversionType)?.symbol ?? "",
              selection: $appState.selectedInputUnit,
              isSelectorOpen: $vm.isConversionTypeSelectorOpen,
              unitOptions: appState.selectedConversionType.unitTypeNames,
              updateAction: vm.updateInputUnit
            )
            
            //MARK: Output Section
            UnitPickerView(
              title: "\(appState.selectedOutputUnit)",
              value: vm.outputValue,
              unitSymbol: appState.selectedOutputUnit.unit(for: appState.selectedConversionType)?.symbol ?? "",
              selection: $appState.selectedOutputUnit,
              isSelectorOpen: $vm.isConversionTypeSelectorOpen,
              unitOptions: appState.selectedConversionType.unitTypeNames,
              updateAction: vm.updateOutputUnit
            )
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
        
        Spacer()
        
        HStack {
          //MARK: Search
          VStack {
            Button(action: {
              isSearchOpen = true
            }) {
              HStack {
                Image(systemName: "magnifyingglass")
                Text("Search")
                  .font(.headline)
              }
              .padding(10)
              .background(Capsule().fill(Color(.systemGray4)))
            }
          }
          .padding(.horizontal)
          .sheet(isPresented: $isSearchOpen) {
            SearchSheet(
              searchText: $searchText,
              suggestions: $suggestions,
              onSelect: { suggestion in
                if let suggestion = suggestion {
                  // Update AppState with the selected conversion
                  appState.selectedConversionType = suggestion.conversionType
                  appState.selectedInputUnit = suggestion.unitName
                  appState.selectedOutputUnit = defaultOutputUnit(for: suggestion.conversionType, inputUnit: suggestion.unitName)
                  vm.getLastUsedValue()
                }
                isSearchOpen = false // Close the sheet
              }
            )
          }
          
          Spacer()
          
          //MARK: Favorites
          FavoritesView(vm: vm, isSelectorOpen: $isFavoritesOpen)
            .environmentObject(appState)
        }
        
        Spacer()
        
        //MARK: Keyboard
        NumericKeyboard { key in
          vm.handleKeyPress(key)
        }
        
        Spacer()
      }
      .background(Color.brown.opacity(0.1).edgesIgnoringSafeArea(.all))
      .onAppear {
        vm.updateConversionType()
      }
    }
  }
  
  private func defaultOutputUnit(for conversionType: ConversionType, inputUnit: String) -> String {
    let units = conversionType.unitTypeNames
    guard units.count > 0 else {
      return inputUnit
    }
    return units.first(where: { $0 != inputUnit }) ?? inputUnit
  }
}

//#Preview {
//  MainView(vm: MainViewModel())
//}
