//
//  SettingsManager.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

final class SettingsManager {
   
    static let shared = SettingsManager()
    
    private(set) var currentThemeName: ThemeName = ThemeName(rawValue: UserDefaultsManager.shared.themeName) ?? .light
            
    private init() {
        
    }
        
}

// MARK: - Set
extension SettingsManager {
    
    func set(currentThemeName: ThemeName?) {
        let name = currentThemeName ?? ThemeName.light
        UserDefaultsManager.shared.themeName = name.rawValue
        self.currentThemeName = name
        Theme.shared.update()
    }
    
}

