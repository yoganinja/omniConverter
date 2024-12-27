//
//  StringExtensions.swift
//  omniConverter
//
//  Created by John Florian on 12/24/24.
//

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
