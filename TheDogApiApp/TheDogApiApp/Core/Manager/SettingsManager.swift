//
//  SettingsManager.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

final class SettingsManager {
   
    static let shared = SettingsManager()
    
    private(set) var currentThemeName: ThemeName = ThemeName(rawValue: UserDefaultsManager.shared.themeName) ?? .system
            
    private init() {
        update()
    }
        
}

// MARK: - Set
extension SettingsManager {
    
    func set(currentThemeName: ThemeName?) {
        let name = currentThemeName ?? ThemeName.system
        self.currentThemeName = name
        UserDefaultsManager.shared.themeName = name.rawValue
        update()
    }
    
}

// MARK: - Update
private extension SettingsManager {
    
    func update() {
        Theme.shared.update()
    }
    
}

