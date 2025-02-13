//
//  UnitPickerView.swift
//  omniConverter
//
//  Created by John Florian on 2/12/25.
//

//import SwiftUI
//
//struct UnitPickerView<T: Hashable>: View {
//  let title: String
//  let value: String
//  let unitSymbol: String
//  @Binding var selection: T
//  @Binding var isSelectorOpen: Bool
//  let unitOptions: [T]
//  let updateAction: () -> Void
//  
//  var body: some View {
////    GeometryReader { geometry in
//      HStack {
//        ValuePicker(
//          title: {
//            HStack {
//              VStack(alignment: .leading) {
//                HStack(alignment: .center) {
//                  Text("\(title) (\(unitSymbol))")
//                }
//                .padding(.vertical, 8)
//                
//                HStack(alignment: .lastTextBaseline) {
//                  Text(value)
//                    .font(.largeTitle)
//                    .minimumScaleFactor(0.5)
//                    .lineLimit(1)
//                    .padding(.vertical, 4)
//                  Text(unitSymbol)
//                    .font(.subheadline)
//                }
//                .foregroundColor(.red)
//              }
//              Spacer()
//              Image(systemName: "chevron.right")
//                .resizable()
//                .frame(width: 24, height: 24)
//            }
//          },
//          selection: $selection,
//          isSelectorOpen: $isSelectorOpen
//        ) {
//          ForEach(unitOptions, id: \.self) { name in
//            Text(verbatim: "\(name) (\(unitSymbol))")
//              .pickerTag(name)
//          }
////          ForEach(appState.selectedConversionType.unitTypeNames, id: \.self) { name in
////              if let unitSymbol = name.unit(for: appState.selectedConversionType)?.symbol {
////                  Text(verbatim: "\(name) (\(unitSymbol))")
////                      .pickerTag(name)
////              } else {
////                  Text(verbatim: "\(name)")
////                      .pickerTag(name)
////              }
////          }
//
//        }
//        .onChange(of: selection) { _ in
//          updateAction()
//        }
//      }
//      .frame(maxWidth: .infinity, minHeight: 100, maxHeight: UIScreen.main.bounds.height * 0.2)
//      .padding(.horizontal)
//      .background(Color.white)
//      .cornerRadius(8)
//      .shadow(radius: 2)
//      .padding(.horizontal)
//      .padding(.top, 5)
////    }
//  }
//}



import SwiftUI

struct UnitPickerView<T: Hashable>: View {
    let title: String
    let value: String
    let unitSymbol: String
    @Binding var selection: T
    @Binding var isSelectorOpen: Bool
    let unitOptions: [T]
    let conversionType: ConversionType
    let updateAction: () -> Void

    var body: some View {
        HStack {
            ValuePicker(
                title: {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Text("\(title) (\(unitSymbolFor(selection)))") // Corrected symbol retrieval
                            }
                            .padding(.vertical, 8)
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text(value)
                                    .font(.largeTitle)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                    .padding(.vertical, 4)
                                Text("\(unitSymbolFor(selection))") // Corrected symbol retrieval
                                    .font(.subheadline)
                            }
                            .foregroundColor(.red)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                },
                selection: $selection,
                isSelectorOpen: $isSelectorOpen
            ) {
                ForEach(unitOptions, id: \.self) { name in
                    Text(verbatim: "\(name) (\(unitSymbolFor(name)))")
                        .pickerTag(name)
                }
            }
            .onChange(of: selection) { _ in
                updateAction()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top, 5)
    }

    private func unitSymbolFor(_ unit: T) -> String {
        (unit as? String)?.unit(for: conversionType)?.symbol ?? "" // Ensures correct symbol lookup
    }
}
