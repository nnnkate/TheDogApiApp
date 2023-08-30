//
//  UserDefaults.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()
    
    private override init() { }
    
    enum Key: String, CaseIterable {
        case themeName = "themeName"
    }
    
}

// MARK: - Param
extension UserDefaultsManager {
    
    var themeName: String {
        set { save(value: newValue, key: .themeName) }
        get { get(key: .themeName) }
    }
    
}

// MARK: - Get
private extension UserDefaultsManager {
    
    func get(key: Key) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    func getDictionary(key: Key) -> NSDictionary? {
        return UserDefaults.standard.object(forKey:key.rawValue) as? NSDictionary
    }
    
    func getArray(key: Key) -> [Any] {
        return UserDefaults.standard.array(forKey: key.rawValue) ?? []
    }
    
    func getStringArray(key: Key) -> [String] {
        return UserDefaults.standard.array(forKey: key.rawValue) as? [String] ?? []
    }
    
    func getBoolArray(key: Key) -> [Bool] {
        return UserDefaults.standard.array(forKey: key.rawValue) as? [Bool] ?? []
    }
    
    func getIntArray(key: Key) -> [Int] {
        return UserDefaults.standard.array(forKey: key.rawValue) as? [Int] ?? []
    }
    
    func getDouble(key: Key) -> Double {
        return UserDefaults.standard.double(forKey:key.rawValue)
    }
    
    func getInt(key: Key) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    func getBool(key: Key) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func getFloat(key: Key) -> Float {
        return UserDefaults.standard.float(forKey: key.rawValue)
    }
    
    func getDate(key: Key) -> Date? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Date
    }
    
}

// MARK: - Save
private extension UserDefaultsManager {
    
    func save(value: String, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: NSDictionary?, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: Optional<Any>, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: Int, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: [String], key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: [Bool], key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: [Int], key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: Bool, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: Double, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func save(value: Date, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
}

