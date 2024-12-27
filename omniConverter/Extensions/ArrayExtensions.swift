//
//  ArrayExtensions.swift
//  omniConverter
//
//  Created by John Florian on 12/24/24.
//

extension Sequence where Element: Identifiable {
  var names: [Element.ID] {
    return self.map { $0.id }
  }
}

extension Array where Element : RawRepresentable {
  var toStrings: [String] {
    get {
      var collection: [String] = []
      for item in self {
        let itemName = item.rawValue as! String
        collection.append(itemName)
      }
      
      return collection
    }
  }
  
  var toTitleStrings: [String] {
    get {
      var collection: [String] = []
      for item in self {
        if let itemName = item.rawValue as? String {
          collection.append(itemName.titleCased)
        }
      }
      
      return collection
    }
  }
  
  var toCamelStrings: [String] {
    get {
      var collection: [String] = []
      for item in self {
        let itemName = item.rawValue as! String
        collection.append(itemName.camelCased)
      }
      
      return collection
    }
  }
}
