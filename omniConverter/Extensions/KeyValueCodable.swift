//
//  KeyValueCodable.swift
//  omniConverter
//
//  Created by John Florian on 12/25/24.
//

// https://owensd.io/2015/07/14/key-value-coding-in-swift/
protocol _KeyValueCodable {
    static var _codables: [KeyValueCodableTypeInfo] { get }
    static var _keyValueCodableStore: Dictionary<String, Any> { get set }
}

struct KeyValueCodableTypeInfo : Hashable {
    let key: String
    let type: Any.Type

    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }

//    // Terrible hash value, just FYI.
//    var hashValue: Int { return key.hashValue &* 3 }
//    static func == (lhs: KeyValueCodableTypeInfo, rhs: KeyValueCodableTypeInfo) -> Bool {
//        return lhs.key == rhs.key && lhs.type == rhs.type
//        }
//    static func != (lhs: KeyValueCodableTypeInfo, rhs: KeyValueCodableTypeInfo) -> Bool {
//        return lhs.key != rhs.key || lhs.type != rhs.type
//        }
}

func ==(lhs: KeyValueCodableTypeInfo, rhs: KeyValueCodableTypeInfo) -> Bool {
    return lhs.key == rhs.key && lhs.type == rhs.type
}

protocol KeyValueCodable : _KeyValueCodable {
    static func setValue<T>(value: T, forKey: String) throws
    static func getValue<T>(forKey: String) throws -> T
}

extension KeyValueCodable {
    // TODO: Call this sometime to actually set the default values!
    static func setValue<T>(value: T, forKey: String) {
        for codable in Self._codables {
            if codable.key == forKey {
                if type(of: value) != codable.type {
                    fatalError("The stored type information does not match the given type.")
                }

                _keyValueCodableStore[forKey] = value
                return
            }
        }

        fatalError("Unable to set the value for key: \(forKey).")
    }

    static func getValue<T>(forKey: String) -> T {
        guard let stored = _keyValueCodableStore[forKey] else {
            fatalError("The property is not set; default values are not supported.")
        }

        guard let value = stored as? T else {
            fatalError("The stored value does not match the expected type.")
        }

        return value
    }
}
