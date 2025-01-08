//
//  FavoriteConversion.swift
//  omniConverter
//
//  Created by John Florian on 1/7/25.
//

import SwiftUICore

struct FavoriteConversion: Codable, Hashable {
  var conversionType: ConversionType
  var inputUnit: String
  var outputUnit: String
}

struct FavoriteConversionRow: View {
  let uuid: UUID
  let favorite: FavoriteConversion
  
  var body: some View {
    Text("\(favorite.conversionType.rawValue) (\(favorite.inputUnit) → \(favorite.outputUnit))")
  }
}
