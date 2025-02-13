//
//  StringExtensions.swift
//  omniConverter
//
//  Created by John Florian on 12/24/24.
//

import Foundation

public extension String {
  var titleCased: String {
    var string = ""
    
    for char in self {
      string += char.description == char.description.capitalized
      ? char.description == " "
      ? char.description
      : " " + char.description
      : char.description
    }
    
    return string.capitalized
  }
  
  var camelCased: String {
    let string = capitalized
    let words = string.components(separatedBy: " ")
    let firstLetter = String(self.first!).lowercased()
    let remainingLetters = String(words[0].self.dropFirst()).lowercased()
    let firstWord = firstLetter + remainingLetters
    let camelCasedString = firstWord + words.dropFirst().joined()
    
    return camelCasedString
  }
  
  var stripSpaces: String {
    let trimmedString = replacingOccurrences(of: " ", with: "")
    
    return trimmedString
  }
}

public extension Double {
  var formatNumber: String {
    let threshold = 0.001 // Define the threshold for using significant figures
    
    if abs(self) >= threshold {
      // Round to the nearest thousandth
      return String(format: "%.3f", self)
    } else {
      // Format with 3 significant digits while keeping it in decimal notation
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.maximumSignificantDigits = 3
      formatter.usesSignificantDigits = true
      return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
  }
}
