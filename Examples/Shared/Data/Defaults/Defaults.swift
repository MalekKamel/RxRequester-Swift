//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

class Defaults {
    static let shared = Defaults()

    var endpoint: Endpoint {
        get {
            guard let value: String = UserDefaultsManager.value(for: .endPoint) else { return Endpoint.posts }
           return Endpoint(rawValue: value) ?? Endpoint.posts
        }
        set { UserDefaultsManager.save(value: newValue.rawValue, key: .endPoint) }
    }
}

enum DefaultsKey: String {
    case endPoint = "endPoint"
}

struct UserDefaultsManager {

    static func save<T: Codable>(
            value: T,
            keyEncoded: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    static func value<T: Decodable>(
            forEncoded key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? {

        guard let data: Data = defaults.value(forKey: key.rawValue) as? Data  else {
            return nil
        }

        return try? PropertyListDecoder().decode(T.self, from: data) as T
    }

    static func saveArray<T: Codable>(
            value: [T],
            keyEncoded: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    static func valueArray<T: Decodable>(
            forEncoded key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> [T]? {

        guard let data: Data = defaults.value(forKey: key.rawValue) as? Data  else {
            return nil
        }

        return try? PropertyListDecoder().decode([T].self, from: data) as [T]
    }

    static func save(
            value: Any?,
            key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(value, forKey: key.rawValue)
        defaults.synchronize()
    }

    static func value<T>(
            for key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? { defaults.value(forKey: key.rawValue) as? T }

    static func clearValue(
            for key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(nil, forKey: key.rawValue)
        defaults.synchronize()
    }

    static func clear(_ defaults: UserDefaults = UserDefaults.standard){
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count)
    }
}